class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :trip_id
      t.integer :user_id
      t.boolean :pay_status, default: false
      t.string :title
      t.float :amount

      t.timestamps null: false
    end
  end
end
