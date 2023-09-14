class EmbeddedReviewsProductRenderer
  def initialize(product)
    @product = product
  end

  def call
    @product.as_json(include: :reviews)
  end
end
