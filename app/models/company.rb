class Company < ActiveRecord::Base

  validates :company_name, :presence => true

  has_many :restaurants
end
