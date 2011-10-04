class Ecrow < ActiveRecord::Base
	belongs_to :endcount
	
	validates :end_count, :presence => true
end
