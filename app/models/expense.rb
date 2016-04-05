class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :expense_splits
  has_many :users, through: :expense_splits
end
