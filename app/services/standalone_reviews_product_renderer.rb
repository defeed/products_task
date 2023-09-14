class StandaloneReviewsProductRenderer
  include Rails.application.routes.url_helpers

  def initialize(product)
    @product = product
  end

  def call
    @product.attributes.merge({ reviews_path: product_reviews_path(@product) }).as_json
  end
end
