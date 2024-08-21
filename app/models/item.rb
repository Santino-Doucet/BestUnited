class Item < ApplicationRecord
  belongs_to :company
  has_one_attached :photo

  validates :reference, :brand, :model, :color, :price, :size, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 1 }

  include PgSearch::Model
  pg_search_scope :search_by_brand_model_reference_and_color,
    against: [ :brand, :model, :reference, :color ],
    using: {
      tsearch: { prefix: true }
    }
end
