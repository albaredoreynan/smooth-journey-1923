class Restaurant < ActiveRecord::Base

  validates :name,     :presence => true

  belongs_to :company
  has_one :branch
  
end
