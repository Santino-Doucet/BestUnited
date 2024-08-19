class Company < ApplicationRecord
  belongs_to :user
  has_many :items, :orders
  validates :siren, :name, presence: true
end
