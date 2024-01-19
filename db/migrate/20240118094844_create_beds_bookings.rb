class CreateBedsBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :beds_bookings do |t|
      t.references :bed, null: false, foreign_key: true
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
