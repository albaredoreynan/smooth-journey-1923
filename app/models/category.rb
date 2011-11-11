class Category < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :csrow
  has_many :subcategories
end
