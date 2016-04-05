class CreateFlightSplits < ActiveRecord::Migration
  def change
    create_table :flight_splits do |t|
      t.integer "flight_id"
      t.integer "user_id"

      t.timestamps null: false
    end
  end
end
