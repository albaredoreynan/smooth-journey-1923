class Restaurant < ActiveRecord::Base

  validates :store_id, :presence => true
  validates :restaurant_name, :presence => true

  belongs_to :company
  has_one :branch
end
