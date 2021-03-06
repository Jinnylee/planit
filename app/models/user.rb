class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :user_trips
  has_many :trips, through: :user_trips
  has_many :expense_splits
  has_many :expenses, through: :expense_splits
  has_many :flight_splits
  has_many :flights, through: :flight_splits
  has_many :accommodation_splits
  has_many :accommodations, through: :accommodation_splits
  has_many :chats
end
