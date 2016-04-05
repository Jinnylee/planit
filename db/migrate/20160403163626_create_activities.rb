class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :trip_id
      t.datetime :date
      t.datetime :time
      t.string :title
      t.text :description
      t.string :location
      t.string :link
      t.float :price

      t.timestamps null: false
    end
  end
end
