puts 'Destroying all records..'
User.destroy_all
Hostel.destroy_all

puts '-------------------------'
puts 'Creating users...'

tim = User.create!(email: 'tim@gmail.com', password:'123456', first_name:'Timothée', last_name:'Régis', birthdate: Date.new(1993,9,1), phone: '0769181771', country:'France')
gladys = User.create!(email: 'gladys@gmail.com', password:'123456', first_name: 'Gladys', last_name:'Barthélémy', birthdate: Date.new(1993,8,27), phone: '0769181771', country:'France')
pauline = User.create!(email: 'pauline@gmail.com', password:'123456', first_name:'Pauline', last_name: 'Jaillant', birthdate: Date.new(1994,3,5), phone: '0769181771', country:'France')

puts "#{User.count} users created!"

puts '-------------------------'

puts 'Creating hostels...'

coast = Hostel.create!(name:'Coast', address: '22 rue Harispe, 64200 Biarritz', capacity: 15)
garden = Hostel.create!(name:'Garden', address: '22 avenue Migron, 64200 Biarritz', capacity: 15)

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
