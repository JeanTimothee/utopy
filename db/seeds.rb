puts 'Destroying all records..'
User.destroy_all
Contact.destroy_all
Booking.destroy_all
Hostel.destroy_all

puts '-------------------------'
puts 'Creating users...'

tim = User.create!(email: 'tim@gmail.com', password:'123456', admin: true)
gladys = User.create!(email: 'gladys@gmail.com', password:'123456', admin: true)
pauline = User.create!(email: 'pauline@gmail.com', password:'123456', admin: true)

puts "#{User.count} users created!"

puts '-------------------------'

puts 'Creating hostels...'

coast = Hostel.create!(name:'Coast', address: '22 rue Harispe, 64200 Biarritz', capacity: 15, opening: Date.new(2024,3,1), closing: Date.new(2024,11,4))
garden = Hostel.create!(name:'Garden', address: '27 avenue Migron BAT E, 64200 Biarritz', capacity: 15, opening: Date.new(2024,3,1), closing: Date.new(2024,11,4))

puts "#{Hostel.count} hostels created!"

puts '-------------------------'

puts "Creating beds... "

30.times do |i|
  new_bed = Bed.new(number: i > 14 ? i - 14: i + 1)
  i.odd? ? new_bed.hostel = garden : new_bed.hostel = coast
  new_bed.save!
end

puts "#{Bed.count} beds created!"
puts '-------------------------'

# pricings

pricing_coast = Pricing.new(
  march: 4300,
  april: 4600,
  may_october: 4900,
  june_september: 5200,
  summer: 5500,
  special_weekends: 6300,
  sejour_tax: 115,
  tva: 10,
  reduction_2_6: 5,
  reduction_7_plus: 10
)

pricing_coast.hostel = coast
pricing_coast.save!

pricing_garden = Pricing.new(
  march: 3300,
  april: 3600,
  may_october: 3900,
  june_september: 4200,
  summer: 4500,
  special_weekends: 5300,
  sejour_tax: 115,
  tva: 10,
  reduction_2_6: 5,
  reduction_7_plus: 10
)

pricing_garden.hostel = garden
pricing_garden.save!

puts "Creating bookings with contacts "

contact_1 = Contact.new(first_name:'Timothée', last_name:'Régis', birthdate: Date.new(1993,9,1), phone: '0769181771', country:'France', email: 'tim@gmail.com')
contact_2 = Contact.new(first_name: 'Gladys', last_name:'Barth', birthdate: Date.new(1993,8,27), phone: '0769181771', country:'France', email: 'gladys@gmail.com')
contact_3 = Contact.new(first_name:'Pauline', last_name:'Popo', birthdate: Date.new(1994,3,5), phone: '0769181771', country:'France', email: 'pauline@gmail.com')

contacts = [contact_1, contact_2, contact_3]

contacts.each_with_index do |contact, i|
  booking = Booking.new(start_date: Date.new(2024,8,(3 + i)), end_date: Date.new(2024,8,(7 + i)))
  booking.hostel_id = Hostel.first.id
  booking.total_price_cents = 4000 * (booking.end_date - booking.end_date).to_i
  booking.number_of_beds = 1
  booking.save!
  contact.booking = booking
  contact.save!
  beds_booking = BedsBooking.new()
  beds_booking.booking = booking
  bed = Bed.joins(:hostel).where(hostel: { name:'Coast'})[i]
  beds_booking.bed = bed
  beds_booking.save!
end

puts "#{Booking.count} bookings created!"
puts '-------------------------'
