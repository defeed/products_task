require 'test_helper'

class EmbeddedReviewsProductRendererTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      id: 1,
      name: 'Sample Product',
      price: BigDecimal('19.99')
    )

    @renderer = EmbeddedReviewsProductRenderer.new(@product) # Initialize the renderer
  end

  test 'call method returns the expected JSON structure' do
    expected_json = {
      id: 1,
      name: 'Sample Product',
      price: '19.99',
      created_at: nil,
      updated_at: nil,
      reviews: []
    }.as_json

    result = @renderer.call
    assert_equal expected_json, result
  end
end
