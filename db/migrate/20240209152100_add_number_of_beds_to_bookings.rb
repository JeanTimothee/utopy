class AddNumberOfBedsToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :number_of_beds, :integer
  end
end
