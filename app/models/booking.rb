class Booking < ApplicationRecord
  belongs_to :user
  has_many :beds_bookings, dependent: :destroy
end
