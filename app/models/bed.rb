class Bed < ApplicationRecord
  belongs_to :hostel
  has_many :beds_bookings, dependent: :destroy
  has_many :bookings, through: :beds_bookings
end
