class Unit < ActiveRecord::Base
  validates :name, :presence => true
end
