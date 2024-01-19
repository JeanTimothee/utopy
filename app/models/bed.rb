class Bed < ApplicationRecord
  belongs_to :hostel
  has_many :beds_bookings, dependent: :destroy
end
