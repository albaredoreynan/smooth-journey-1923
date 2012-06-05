class Unit < ActiveRecord::Base
  acts_as_paranoid
  
  validates :symbol, :presence => true

  belongs_to :restaurant
  has_many :conversion_to, :class_name => 'Conversion', :foreign_key => :bigger_unit_id, :dependent => :destroy

  scope :search, lambda { |keyword| where("units.name ILIKE :keyword OR units.symbol ILIKE :keyword", { :keyword => "%#{keyword}%" }) }
end
