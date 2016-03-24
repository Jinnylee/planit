class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer "user_id"
      t.string "location"
      t.date "start_date"
      t.date "end_date"
      t.string "activity"
      t.string "packing"
      t.boolean "status"

      t.timestamps null: false
    end
  end
end
