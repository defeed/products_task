require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "should save a valid product" do
    product = Product.new(name: "Example Product", price: 19.99)
    assert product.save, "Could not save a valid product"
  end

  test "should not save a product without a name" do
    product = Product.new(price: 19.99)
    assert_not product.save, "Saved a product without a name"
  end

  test "should not save a product with a negative price" do
    product = Product.new(name: "Negative Price Product", price: -5.0)
    assert_not product.save, "Saved a product with a negative price"
  end

  test "should have many reviews" do
    product = Product.new(name: "Reviewable Product", price: 29.99)
    review1 = product.reviews.build(content: "Great product!", rating: 5)
    review2 = product.reviews.build(content: "Not bad, but could be better.", rating: 3)

    assert product.save, "Could not save product with reviews"
    assert_equal 2, product.reviews.count, "Product should have 2 reviews"
  end
end
