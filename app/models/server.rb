class Server < ActiveRecord::Base

  validates :name, :presence => true
  validates :branch_id, :presence => true

  belongs_to :branch
end
