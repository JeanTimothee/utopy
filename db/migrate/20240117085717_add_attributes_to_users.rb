class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :phone, :string
    add_column :users, :country, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
