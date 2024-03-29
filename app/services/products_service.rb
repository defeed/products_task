class ProductsService
  include Rails.application.routes.url_helpers

  def initialize(product)
    @product = product
  end

  def product_data
    # Define the default behavior in case feature flag is removed or name is changed in future
    if FeatureFlagsService.is_enabled?('standalone_reviews', true)
      @product.attributes.merge({ reviews_path: product_reviews_path(@product) }).as_json
    else
      @product.as_json(include: :reviews)
    end
  end
end
