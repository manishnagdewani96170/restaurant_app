class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :tables, through: :reservations, dependent: :destroy

  validates :name, :email, presence: :true
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
end
