class Department < ActiveRecord::Base
	belongs_to :restaurant
	has_many :employees
end
