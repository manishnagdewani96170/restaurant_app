class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :reservations, dependent: :destroy
  has_many :guests, through: :reservations, dependent: :destroy
end
