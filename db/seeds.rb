# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

foo = Product.create(name: "Foo", price: 9.99)
bar = Product.create(name: "Bar", price: 19.99)

foo.reviews.create(content: "Great product!", rating: 5)
foo.reviews.create(content: "Not bad, but could be better.", rating: 3)
foo.reviews.create(content: "Not what I expected", rating: 1)

bar.reviews.create(content: "Amazing value for the price.", rating: 4)
bar.reviews.create(content: "Best thing ever", rating: 5)
