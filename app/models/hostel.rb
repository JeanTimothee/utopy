class Hostel < ApplicationRecord
  has_many :beds, dependent: :destroy
  has_one :pricing, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
