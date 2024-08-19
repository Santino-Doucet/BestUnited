class Item < ApplicationRecord
  belongs_to :company

  validates :reference, :brand, :model, :color, :price, :size, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 1 }
  validates :reference, uniqueness: { scope: [:color, :size], message: "Combination with color and size must be unique, combination already exists" }
end
