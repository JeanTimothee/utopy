class AddCoordinatesToHostels < ActiveRecord::Migration[7.1]
  def change
    add_column :hostels, :latitude, :float
    add_column :hostels, :longitude, :float
  end
end
