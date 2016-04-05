class Trip < ActiveRecord::Base
  has_many :user_trips
  has_many :users, through: :user_trips
  has_many :invitations
  has_many :expenses
  has_many :accommodations
  has_many :flights
  has_many :packings
  has_many :activities
  has_many :chats
end
