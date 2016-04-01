class CreateAccommodationSplits < ActiveRecord::Migration
  def change
    create_table :accommodation_splits do |t|
      t.integer "accommodation_id"
      t.integer "user_id"

      t.timestamps null: false
    end
  end
end
