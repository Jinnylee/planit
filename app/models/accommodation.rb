class Accommodation < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :accommodation_splits
  has_many :users, through: :accommodation_splits
end
