class Company < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :siren, :name, presence: true
  validates :siren, uniqueness: true
end
