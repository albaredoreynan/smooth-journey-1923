class Endcount < ActiveRecord::Base
	has_many :ecrows
	accepts_nested_attributes_for :ecrows
	
	
end
