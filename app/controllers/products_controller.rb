class ProductsController < ApplicationController
  def index
    @products = Product.select(:id, :name, :price)
    render json: @products
  end

  def show
    @product = Product.find(params[:id])
    render json: @product.to_json(include: :reviews)
  end
end
