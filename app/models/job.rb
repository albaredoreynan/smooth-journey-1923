class Job < ActiveRecord::Base
	belongs_to :department
	has_many :employees
end
