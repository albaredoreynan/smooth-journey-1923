class Branch < ActiveRecord::Base

  validates :location, :presence => true
  validates :restaurant_id, :presence => true

  belongs_to :restaurant
end
