class Category < ActiveRecord::Base
  has_many :subcategories
  belongs_to :csrow
end
