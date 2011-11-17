class Unit < ActiveRecord::Base
  validates :name, :presence => true
  
  def self.search(keyword)
    unless keyword.empty?
      where("name LIKE ?", '%'+keyword+'%')
    else
      all
    end
  end
end
