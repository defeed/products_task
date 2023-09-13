require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:foo)
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get product/:id with nested reviews' do
    get product_url(@product)
    assert_response :success

    json_response = JSON.parse(response.body)
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
end
