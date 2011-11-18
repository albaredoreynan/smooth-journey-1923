class Item < ActiveRecord::Base

  validates :name, :presence => true

  belongs_to :unit
  belongs_to :branch
  has_many :purchase_items

  def self.search(keyword)
    unless keyword.empty?
      where("name LIKE ?", '%'+keyword+'%')
    else
      all
    end
  end
end
