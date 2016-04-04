class CreatePackings < ActiveRecord::Migration
  def change
    create_table :packings do |t|
      t.integer :trip_id
      t.string :item
      t.timestamps null: false
    end
  end
end
