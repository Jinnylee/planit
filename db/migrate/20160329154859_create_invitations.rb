class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :trip_id
      t.integer :status, default: false

      t.timestamps null: false
    end
  end
end
