class RemoNameToContacts < ActiveRecord::Migration[7.1]
  def change
    remove_column :contacts, :name
    add_column :contacts, :first_name, :string
    add_column :contacts, :last_name, :string
  end
end
