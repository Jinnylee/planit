class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :expense_splits
end
