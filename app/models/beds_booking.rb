class BedsBooking < ApplicationRecord
  belongs_to :bed
  belongs_to :booking
end
