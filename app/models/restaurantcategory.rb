class Restaurantcategory < ActiveRecord::Base
	belongs_to :restaurant
	has_many :categories
end
