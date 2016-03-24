class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :location
      t.datetime :start_date
      t.datetime :end_date
      t.text :activity # serialize Array
      t.text :packing # serialize Array

      t.timestamps null: false
    end
  end
end
