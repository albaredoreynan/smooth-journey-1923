class SaleCategory < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :restaurant
end
