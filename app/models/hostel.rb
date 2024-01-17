class Hostel < ApplicationRecord
  has_many :beds
  has_one :pricing
end
