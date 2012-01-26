class Branch < ActiveRecord::Base

  validates :location, :presence => true
  validates :restaurant_id, :presence => true

  belongs_to :restaurant

  def company
    restaurant.company
  end

  def settings
    company.settings
  end
end
