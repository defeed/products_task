require 'test_helper'

class ProductsServiceTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers

  test 'product_data should include reviews_path when standalone_reviews feature flag is enabled' do
    product = Product.create(name: 'Product A', price: 9.99)
    feature_flag = FeatureFlag.create(name: 'standalone_reviews', value: true)

    product_data = ProductsService.new(product).product_data

    assert_equal product.id, product_data['id']
    assert_equal product.name, product_data['name']
    assert_equal product.price.to_s, product_data['price']
    assert_equal product_reviews_path(product), product_data['reviews_path']
  end

  test 'product_data should include reviews when standalone_reviews feature flag is disabled' do
    product = Product.create(name: 'Product B', price: 19.99)
    feature_flag = FeatureFlag.create(name: 'standalone_reviews', value: false)
    review = Review.create(product: product, content: 'Great product!', rating: 5)

    product_data = ProductsService.new(product).product_data

    assert_equal product.id, product_data['id']
    assert_equal product.name, product_data['name']
    assert_equal product.price.to_s, product_data['price']
    assert_equal [review.as_json], product_data['reviews']
  end
end
