class CreateBeds < ActiveRecord::Migration[7.1]
  def change
    create_table :beds do |t|
      t.integer :number
      t.references :hostel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
