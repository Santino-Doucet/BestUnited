class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable

  has_many :companies, dependent: :destroy
  has_many :carts, dependent: :destroy

  validates :age, comparison: { greater_than_or_equal_to: 18 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
end
