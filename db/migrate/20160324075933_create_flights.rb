class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer "trip_id"
      t.integer "user_id"
      t.date "departure_date"
      t.time "departure_time"
      t.date "arrival_date"
      t.time "arrival_time"
      t.string "departure_airport"
      t.string "arrival_airport"
      t.string "airline"
      t.string "flight_number"
      t.string "terminal"

      t.timestamps null: false
    end
  end
end
