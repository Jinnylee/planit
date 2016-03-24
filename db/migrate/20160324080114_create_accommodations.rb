class CreateAccommodations < ActiveRecord::Migration
  def change
    create_table :accommodations do |t|
      t.integer "trip_id"
      t.integer "user_id"
      t.date "check_in"
      t.time "check_in_time"
      t.date "check_out"
      t.time "check_out_time"
      t.string "name"
      t.string "location"
      t.image "image"
      t.text "description"
      t.string "confirmation_number"
      t.string "price"

      t.timestamps null: false
    end
  end
end
