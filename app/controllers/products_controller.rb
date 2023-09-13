class ProductsController < ApplicationController
  def index
    products = Product.select(:id, :name, :price)
    render json: products
  end

  def show
    product = Product.find_by(id: params[:id])
    unless product
      render json: { error: "Product not found" }, status: :not_found and return
    end

    render json: ProductsService.new(product).product_data
  end
end
