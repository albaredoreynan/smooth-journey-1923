class Branch < ActiveRecord::Base

  validates :location, :presence => true
  validates :restaurant_id, :presence => true

  belongs_to :restaurant
  has_many :sales, :dependent => :destroy
  has_many :items, :dependent => :destroy  

  def company
    restaurant.company
  end

  def settings
    company.settings
  end
end
