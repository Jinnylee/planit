class AddLinkToAccommodations < ActiveRecord::Migration
  def change
    add_column :accommodations, :link, :string
  end
end
