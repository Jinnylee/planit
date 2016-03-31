class Flight < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :flight_splits
  has_many :users, through: :flight_splits
end
