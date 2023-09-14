require 'test_helper'
require 'minitest/mock'

class ProductsServiceTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      id: 1,
      name: 'Sample Product',
      price: BigDecimal('19.99')
    )
  end

  test 'product_data returns the correct JSON when standalone reviews feature flag is enabled' do
    # Stub the is_enabled? method to return false for the specified feature flag
    FeatureFlagsService.stub(:is_enabled?, true) do
      expected_json = {
        id: 1,
        name: 'Sample Product',
        price: '19.99',
        created_at: nil,
        updated_at: nil,
        reviews_path: '/products/1/reviews' # Adjust the expected result
      }.as_json

      result = ProductsService.new(@product).product_data
      assert_equal expected_json, result
    end
  end

  test 'product_data returns the correct JSON when standalone reviews feature flag is disabled' do
    # Stub the is_enabled? method to return false for the specified feature flag
    FeatureFlagsService.stub(:is_enabled?, false) do
      expected_json = {
        id: 1,
        name: 'Sample Product',
        price: '19.99',
        created_at: nil,
        updated_at: nil,
        reviews: []
      }.as_json

      result = ProductsService.new(@product).product_data
      assert_equal expected_json, result
    end
  end
end
