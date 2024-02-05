class RemoveUserFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bookings, :user, null: false, foreign_key: true
  end
end
