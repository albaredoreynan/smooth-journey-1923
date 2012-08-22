class Subcategory < ActiveRecord::Base

  validates :name, :presence => true
  validates :category_id, :presence => true

  belongs_to :category;
  has_many :items, :dependent => :destroy
end
