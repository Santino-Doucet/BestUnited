class Company < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  validates :siren, :name, presence: true
  validates :siren, uniqueness: true
end
