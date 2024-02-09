class Hostel < ApplicationRecord
  has_many :beds, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_one :pricing, dependent: :destroy
  has_many :beds_bookings, through: :bookings


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # not used
  # def booked_beds_at_date(date)
  #   bookings_on_date = bookings.where("? BETWEEN start_date AND end_date", date)
  #   booked_bed_ids = bookings_on_date.flat_map(&:bed_ids).uniq
  #   beds.where(id: booked_bed_ids)
  # end

  def available_beds(start_date, end_date)
    beds.where.not(
      id: Bed.joins(:bookings)
             .where("bookings.start_date < ? AND bookings.end_date > ? AND bookings.hostel_id = ?", end_date, start_date, id)
             .select(:id)
    )
  end

  def booked_dates(number_of_beds = 1)
    self.nb_of_bookings_per_dates.select { |key, value| value >= (16 - number_of_beds) }.keys
  end

  def nb_of_bookings_per_dates
    dates = Booking.joins(:hostel).where("end_date > ? AND hostels.id = ?", Date.today, self.id).flat_map { |b| (b.start_date..b.end_date).to_a * b.all_beds.count }
    dates.group_by(&:itself).transform_values(&:count)
  end
end
