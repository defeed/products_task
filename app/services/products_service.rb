class ProductsService
  def initialize(product)
    @product = product
  end

  def product_data
    ProductRenderer.new(@product, renderer: find_renderer).call
  end

  private

  def find_renderer
    if FeatureFlagsService.is_enabled?('standalone_reviews', true)
      StandaloneReviewsProductRenderer
    else
      EmbeddedReviewsProductRenderer
    end
  end
end
