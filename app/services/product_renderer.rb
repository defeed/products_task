class ProductRenderer
  attr_reader :renderer

  def initialize(product, renderer:)
    @product = product
    @renderer = renderer
  end

  def call
    @renderer.new(@product).call
  end
end
