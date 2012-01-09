class Restaurant < ActiveRecord::Base

  validates :store_id, :presence => true,
                       :uniqueness => true
  validates :name,     :presence => true

  belongs_to :company
  has_one :branch
  
end
