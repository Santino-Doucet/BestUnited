class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :company
  has_many :order_items
  has_many :items, through: :order_items
  scope :not_sent, -> {where.not(status: nil)}

  def same_item(item)
    items.where(
      reference:item.reference,
      brand:item.brand,
      model:item.model,
      color:item.color,
      price:item.price,
      size:item.size
    )
  end

  def total_price
    items.sum(:price)
  end
end
