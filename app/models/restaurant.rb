class Restaurant < ApplicationRecord
  
  has_many :tables, dependent: :destroy

  has_many :reservations, dependent: :destroy

  validates :name, :phone, :email, presence: :true

  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }

  validates :phone, format: { with: /[0-9]{3}-[0-9]{3}-[0-9]{4}/, message: "Phone numbers must be in xxx-xxx-xxxx format."}
  
  validates_time :morning_end_shift, after: :morning_start_shift, after_message: "Morning end shift message must be after start shift"

  validates_time :evening_end_shift, after: :evening_start_shift, after_message: "Evening end shift message must be after start shift"

end
