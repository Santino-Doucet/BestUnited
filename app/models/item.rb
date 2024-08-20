class Item < ApplicationRecord
  belongs_to :company
  has_one_attached :photo

  validates :reference, :brand, :model, :color, :price, :size, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 1 }
end
