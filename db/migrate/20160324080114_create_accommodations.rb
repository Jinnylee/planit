class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.integer :trip_id
      t.integer :user_id
      t.datetime :check_in
      t.datetime :check_out
      t.string :name
      t.string :location
      t.text :description
      t.string :confirmation_number
      t.float :price

      t.timestamps null: false
    end
  end
end
