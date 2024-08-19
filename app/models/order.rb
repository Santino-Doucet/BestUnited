class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :company
  has_many :items, through: :order_items
end
