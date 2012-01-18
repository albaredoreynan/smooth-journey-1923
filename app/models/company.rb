class Company < ActiveRecord::Base

  validates :name, :presence => true

  has_one :setting
  has_many :restaurants
end
