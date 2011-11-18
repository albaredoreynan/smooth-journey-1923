class Unit < ActiveRecord::Base
  validates :name, :presence => true
  
  def self.search(keyword)
    where("name LIKE ?", '%'+keyword+'%')
  end
end
