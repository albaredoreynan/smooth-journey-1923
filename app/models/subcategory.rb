class Subcategory < ActiveRecord::Base

  validates :subcategory_name, :presence => true

  belongs_to :category;
end
