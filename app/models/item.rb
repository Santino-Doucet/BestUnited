class Item < ApplicationRecord
  belongs_to :company
  has_one_attached :photo

  validates :brand, :model, :color, :price, :size, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 1 }
  validate :barcode_or_reference_present
  has_many :order_items
  has_many :orders, through: :order_items

  include PgSearch::Model
  pg_search_scope :search_by_brand_model_reference_and_color,
    against: [ :brand, :model, :reference, :color ],
    using: {
      tsearch: { prefix: true }
    }

  def same_in_stock
    company.items.where(
      reference:,
      brand:,
      model:,
      color:,
      price:,
      size:
    )
  end

  private

  def barcode_or_reference_present
    if barcode.blank? && reference.blank?
      errors.add(:base, "Either barcode or reference must be present.")
    end
  end
end
