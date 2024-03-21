class Booking < ApplicationRecord
  belongs_to :hostel
  has_one :contact, dependent: :destroy
  has_many :beds_bookings, dependent: :destroy
  has_many :beds, through: :beds_bookings

  validate :no_overlapping_bookings
  validate :end_date_after_start_date
  validate :before_4_pm

  validates :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(pending confirmed) }


  def all_beds
    beds_bookings.map(&:bed)
  end

  def all_beds_bookings
    beds_bookings
  end

  def calculate_price
    # Determine booking's pricing_table
    pricing = self.hostel.pricing
    # Isolate date range into an array
    dates = dates_array
    # sum each night depending on the price range in the pricing_table
    sum = self.sum_nights(dates, pricing)
    # apply reductions & taxes
    if dates.uniq.size.between?(2,6)
      sum = (sum * (1 - pricing.reduction_2_6.to_f / 100)).to_i
    elsif dates.size >= 7
      sum = (sum * (1 - pricing.reduction_7_plus.to_f / 100)).to_i
    end
    return sum # + (dates.size * pricing.sejour_tax)
  end

  def dates_array
    (self.start_date..(self.end_date - 1)).to_a * number_of_beds
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
      when (Date.new(date.year,7,1)..Date.new(date.year,7,8)) || (Date.new(date.year,7,16)..Date.new(date.year,8,13)) || (Date.new(date.year,8,19)..Date.new(date.year,8,31))
        pricing.summer
      else
        pricing.special_weekends
      end
    end
  end


  private

  # handle in JS datepicker controller as well
  def before_4_pm
    if start_date == Date.today && Time.now.hour >= 16
      errors.add(:start_date, (I18n.t 'before_16'))
    end
  end

  def no_overlapping_bookings
    all_beds.each do |bed|
      overlapping_bookings = bed.bookings.where("status = ? AND start_date < ? AND end_date > ? OR start_date >= ? AND end_date <= ?", "confirmed", end_date, start_date, start_date, end_date)

      if overlapping_bookings.exists? && overlapping_bookings.first != self
        errors.add(:base, "Bed #{bed.number} is already booked for the selected dates")
      end
    end
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
 end
end
