require 'test_helper'

class ProductRendererTest < ActiveSupport::TestCase
  def setup
    @product = Product.new(
      id: 1,
      name: 'Sample Product',
      price: BigDecimal('19.99')
    )
  end

  test 'call method delegates rendering to the provided renderer' do
    embedded_renderer_class = EmbeddedReviewsProductRenderer
    embedded_renderer = embedded_renderer_class.new(@product)

    standalone_renderer_class = StandaloneReviewsProductRenderer
    standalone_renderer = standalone_renderer_class.new(@product)

    embedded_renderer_result = embedded_renderer.call
    standalone_renderer_result = standalone_renderer.call

    embedded_product_renderer = ProductRenderer.new(@product, renderer: embedded_renderer_class)
    standalone_product_renderer = ProductRenderer.new(@product, renderer: standalone_renderer_class)

    assert_equal embedded_renderer_result, embedded_product_renderer.call
    assert_equal standalone_renderer_result, standalone_product_renderer.call
  end
end
