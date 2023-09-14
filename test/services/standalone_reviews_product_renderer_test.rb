require 'test_helper'

class StandaloneReviewsProductRendererTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      id: 1,
      name: 'Sample Product',
      price: BigDecimal('19.99')
    )

    @renderer = StandaloneReviewsProductRenderer.new(@product)
  end

  test 'call method returns the expected JSON structure' do
    expected_json = {
      id: 1,
      name: 'Sample Product',
      price: '19.99',
      created_at: nil,
      updated_at: nil,
      reviews_path: '/products/1/reviews'
    }.as_json

    result = @renderer.call
    assert_equal expected_json, result
  end
end
