class CreateExpenseSplits < ActiveRecord::Migration
  def change
    create_table :expense_splits do |t|
      t.integer "expense_id"
      t.integer "user_id"

      t.timestamps null: false
    end
  end
end
