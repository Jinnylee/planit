class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :trip_id
      t.string :secure_hash
      t.boolean :used, default: false

      t.timestamps null: false
    end
  end
end
