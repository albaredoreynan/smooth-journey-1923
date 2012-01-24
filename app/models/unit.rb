class Unit < ActiveRecord::Base
  validates :symbol, :presence => true

  belongs_to :restaurant

  scope :search, lambda { |keyword| where("units.name ILIKE :keyword OR units.symbol ILIKE :keyword", { :keyword => "%#{keyword}%" }) }
end
