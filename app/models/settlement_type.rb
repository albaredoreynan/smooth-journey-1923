class SettlementType < ActiveRecord::Base

  validates :name, :presence => true
  
  has_many :settlement_type_sales
  belongs_to :restaurant
end
