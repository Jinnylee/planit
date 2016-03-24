class CreateUserTrips < ActiveRecord::Migration
  def change
    create_table :user_trips do |t|
      t.integer :user_id
      t.integer :trip_id

      t.timestamps null: false
    end
  end
end
