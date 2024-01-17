class CreateHostels < ActiveRecord::Migration[7.1]
  def change
    create_table :hostels do |t|
      t.string :name
      t.string :address
      t.integer :capacity

      t.timestamps
    end
  end
end
