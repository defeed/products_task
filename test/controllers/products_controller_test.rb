require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers

  setup do
    @product = products(:foo)
    @feature_flag_enabled = FeatureFlag.create(name: 'standalone_reviews', value: true)
  end

  test 'should get /products' do
    get products_url
    assert_response :success
  end

  test 'should get /products/:id with reviews_path when feature flag is enabled' do
    get product_url(@product)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @product.id, json_response['id']
    assert_equal @product.name, json_response['name']
    assert_equal @product.price.to_s, json_response['price']
    assert_includes json_response, 'reviews_path'
    assert_equal product_reviews_path(@product), json_response['reviews_path']
  end

  test 'should get /products/:id with nested reviews when feature flag is disabled' do
    @feature_flag_enabled.update(value: false)
    get product_url(@product)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal @product.id, json_response['id']
    assert_equal @product.name, json_response['name']
    assert_equal @product.price.to_s, json_response['price']
    assert_includes json_response, 'reviews'
    assert_instance_of Array, json_response['reviews']
    assert_not_empty json_response['reviews']

    json_response['reviews'].each do |review|
      assert_includes review, 'id'
      assert_includes review, 'content'
      assert_includes review, 'rating'
      assert_includes review, 'created_at'
      assert_includes review, 'updated_at'
    end
  end

  test 'should respond with 404 when product does not exist' do
    non_existent_product_id = 9990
    get product_url(non_existent_product_id)
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal({ 'error' => 'Product not found' }, json_response)
  end
end
