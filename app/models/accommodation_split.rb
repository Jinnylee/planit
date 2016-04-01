class AccommodationSplit < ActiveRecord::Base
  belongs_to :accommodation
  belongs_to :user
end
