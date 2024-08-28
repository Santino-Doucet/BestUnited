class Item < ApplicationRecord
  belongs_to :company
  has_one_attached :photo

  validates :brand, :model, :color, :price, :size, presence: true
  validates :price, comparison: { greater_than_or_equal_to: 1 }
  validate :barcode_or_reference_present

  has_many :order_items
  has_many :orders, through: :order_items

  scope :not_in_stock, -> { joins(:orders).where(orders: { status: ["En attente", "Validée", "Refusée", "Effectuée"] }) }
  scope :in_stock, -> { where.not(id: not_in_stock) }

  # Define the scope to find items with the same company, model, brand, price, and color
  scope :similar_items, ->(item) {
    where(
      company_id: item.company_id,
      model: item.model,
      brand: item.brand,
      price: item.price,
      color: item.color
    ).where.not(id: item.id) # Exclude the current item if needed
  }

  include PgSearch::Model
  pg_search_scope :search_by_brand_model_reference_and_color,
                  against: [:brand, :model, :reference, :color],
                  using: {
                    tsearch: { prefix: true }
                  }

  def same_in_stock
    company.items.where(
      reference: reference,
      brand: brand,
      model: model,
      color: color,
      price: price,
      size: size
    )
  end

  def self.remove_duplicates(items)
    unique_items = {}

    items.each do |item|
      key = [item.reference, item.brand, item.model, item.color, item.price]

      if unique_items[key]
        unique_items[key][:count] += 1
      else
        unique_items[key] = { item: item, count: 1 }
      end
    end

    sorted_unique_items = unique_items.values.sort_by { |entry| -entry[:count] }

    sorted_unique_items.map { |entry| entry[:item] }
  end

  private

  def barcode_or_reference_present
    if barcode.blank? && reference.blank?
      errors.add(:base, "Either barcode or reference must be present.")
    end
  end
end
