class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.date :birthdate
      t.string :country
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
