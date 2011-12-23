class Unit < ActiveRecord::Base
  validates :symbol, :presence => true

  def self.search(keyword)
    where("name ILIKE :keyword or symbol ILIKE :keyword", {:keyword => '%'+keyword+'%'})
  end
end
