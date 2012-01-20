class Category < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :restaurant

  has_many :subcategories
end
