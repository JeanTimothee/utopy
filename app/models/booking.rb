class Booking < ApplicationRecord
  belongs_to :hostel
  has_one :contact, dependent: :destroy
  has_many :beds_bookings, dependent: :destroy
  has_many :beds, through: :beds_bookings

  attr_accessor :number_of_beds

  validates :start_date, :end_date, presence: true

  def calculate_price
    # Determine booking's pricing_table
    pricing = self.hostel.pricing
    # Isolate date range into an array
    dates = dates_array
    # sum each night depending on the price range in the pricing_table
    sum = self.sum_nights(dates, pricing)
    # apply reductions & taxes
    if dates.size.between?(2,6)
      sum = (sum * (1 - pricing.reduction_2_6.to_f / 100)).to_i
    elsif dates.size >= 7
      sum = (sum * (1 - pricing.reduction_7_plus.to_f / 100)).to_i
    end
    return sum + (dates.size * pricing.sejour_tax)
  end

  def dates_array
    (self.start_date..(self.end_date - 1)).to_a
  end

  def sum_nights(dates, pricing)
    dates.sum do |date|
      case date
      when (Date.new(date.year,1,5)..Date.new(date.year,3,31))
        pricing.march
      when (Date.new(date.year,4,1)..Date.new(date.year,4,30))
        pricing.april
      when (Date.new(date.year,5,1)..Date.new(date.year,5,31)) || (Date.new(date.year,10,1)..pricing.hostel.closing)
        pricing.may_october
      when (Date.new(date.year,6,1)..Date.new(date.year,6,30)) || (Date.new(date.year,9,1)..Date.new(date.year,9,30))
        pricing.june_september
      when (Date.new(date.year,7,1)..Date.new(date.year,7,12)) || (Date.new(date.year,7,16)..Date.new(date.year,7,25)) || (Date.new(date.year,7,31)..Date.new(date.year,8,11)) || (Date.new(date.year,8,16)..Date.new(date.year,8,31))
        pricing.summer
      else
        pricing.special_weekends
      end
    end
  end
end
