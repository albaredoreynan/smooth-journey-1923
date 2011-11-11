class Category < ActiveRecord::Base

  validates :category_name, :presence => true

  belongs_to :csrow
  has_many :subcategories
end
