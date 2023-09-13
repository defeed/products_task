class Review < ApplicationRecord
  belongs_to :product

  validates :content, presence: true
  validates :rating, presence: true, numericality: { greater_than: 0 }
end
