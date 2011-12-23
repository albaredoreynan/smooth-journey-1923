class Unit < ActiveRecord::Base
  validates :symbol, :presence => true
  
  def self.search(keyword)
    where("name LIKE ?", '%'+keyword+'%')
  end
end
