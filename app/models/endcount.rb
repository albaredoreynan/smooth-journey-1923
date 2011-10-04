class Endcount < ActiveRecord::Base
	has_many :ecrows, :dependent => :destroy #when endcount is destroyed, ecrows will also be destroyed
	accepts_nested_attributes_for :ecrows
	
	#validates :end_count, :presence => true
end