class ReviewsController < ApplicationController
  def index
    product = Product.find_by(id: params[:product_id])
    unless product
      render json: { error: "Product not found" }, status: :not_found and return
    end

    response = {
      product_path: product_path(product),
      reviews: product.reviews
    }

    render json: response
  end
end
