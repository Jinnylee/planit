class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :trip_id
      t.integer :user_id
      t.text :message

      t.timestamps null: false
    end
  end
end
