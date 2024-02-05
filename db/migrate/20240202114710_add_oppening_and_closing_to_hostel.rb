class AddOppeningAndClosingToHostel < ActiveRecord::Migration[7.1]
  def change
    add_column :hostels, :opening, :date
    add_column :hostels, :closing, :date
  end
end
