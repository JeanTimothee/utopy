class CreatePricings < ActiveRecord::Migration[7.1]
  def change
    create_table :pricings do |t|
      t.references :hostel, null: false, foreign_key: true
      t.integer :march
      t.integer :april
      t.integer :may_october
      t.integer :june_september
      t.integer :summer
      t.integer :special_weekends
      t.integer :tva
      t.integer :sejour_tax
      t.integer :reduction_2_6
      t.integer :reduction_7_plus

      t.timestamps
    end
  end
end
