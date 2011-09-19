class Ecrow < ActiveRecord::Base
	belongs_to :endcount
	
	#validates :endcount, :presence => true
end
