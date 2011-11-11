class Unit < ActiveRecord::Base
  validates :unit_name, :presence => true
end
