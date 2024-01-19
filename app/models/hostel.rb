class Hostel < ApplicationRecord
  has_many :beds, dependent: :destroy
  has_one :pricing, dependent: :destroy
end
