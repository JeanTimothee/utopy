class Booking < ApplicationRecord
  belongs_to :user
  has_many :beds_bookings, dependent: :destroy
  has_many :beds, through: :beds_bookings

  attr_accessor :number_of_beds
end
