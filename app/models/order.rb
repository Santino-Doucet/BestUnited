class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :company
end
