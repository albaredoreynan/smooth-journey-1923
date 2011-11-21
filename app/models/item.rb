class Item < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  belongs_to :subcategory
  has_many :purchase_items

  def self.search(keyword)
    where("name LIKE ?", '%'+keyword+'%')
  end
end
