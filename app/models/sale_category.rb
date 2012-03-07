class SaleCategory < ActiveRecord::Base

  validates :name, :presence => true
  validates :restaurant_id, :presence => true

  belongs_to :restaurant
end
