class Branch < ActiveRecord::Base

  validates :branch_location, :presence => true

  belongs_to :restaurant
end
