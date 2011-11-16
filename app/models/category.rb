class Category < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :category_sale
  has_many :subcategories
end
