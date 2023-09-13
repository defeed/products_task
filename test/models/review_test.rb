require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  test "should save a valid review" do
    review = Review.new(product: products(:foo), content: "Great product!", rating: 5)
    assert review.save, "Could not save a valid review"
  end

  test "should not save a review without content" do
    review = Review.new(product: products(:foo), rating: 4)
    assert_not review.save, "Saved a review without content"
  end

  test "should not save a review without a rating" do
    review = Review.new(product: products(:foo), content: "Good product")
    assert_not review.save, "Saved a review without a rating"
  end

  test "should not save a review with a negative rating" do
    review = Review.new(product: products(:foo), content: "Good product", rating: -1)
    assert_not review.save, "Saved a review with a negative rating"
  end

  test "should not save a review with a 0 rating" do
    review = Review.new(product: products(:foo), content: "Good product", rating: 0)
    assert_not review.save, "Saved a review with a 0 rating"
  end

  test "should belong to a product" do
    review = Review.new(content: "Great product!", rating: 5)
    assert_not review.save, "Saved a review without a product"
  end
end
