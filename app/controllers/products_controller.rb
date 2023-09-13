class ProductsController < ApplicationController
  def index
    @products = Product.select(:id, :name, :price)
    render json: @products
  end

  def show
    @product = Product.select(:id, :name, :price).find(params[:id])
    render json: ProductsService.new(@product).product_data
  end
end
