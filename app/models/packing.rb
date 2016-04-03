class Packing < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :packing_splits
  has_many :users, through: :packing_splits
end