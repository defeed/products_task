require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers

  setup do
    @product = products(:foo)
  end

  test 'should get index with reviews when product exists' do
    review1 = Review.create(product: @product, content: 'Great product!', rating: 5)
    review2 = Review.create(product: @product, content: 'Not bad, but could be better.', rating: 3)

    get product_reviews_url(@product)
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_equal product_path(@product), json_response['product_path']

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

  test 'should return error when product does not exist' do
    non_existent_product_id = 9999

    get product_reviews_url(non_existent_product_id)
    assert_response :not_found

    json_response = JSON.parse(response.body)
    assert_equal({ 'error' => 'Product not found' }, json_response)
  end
end
