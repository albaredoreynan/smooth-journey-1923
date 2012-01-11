class Category < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :category_sale
  belongs_to :restaurant
  
  has_many :subcategories
end
