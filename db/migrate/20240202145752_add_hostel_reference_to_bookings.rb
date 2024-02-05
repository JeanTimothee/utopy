class AddHostelReferenceToBookings < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :hostel, null: false, foreign_key: true
  end
end
