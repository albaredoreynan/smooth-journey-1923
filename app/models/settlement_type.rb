class SettlementType < ActiveRecord::Base

  validates :name, :presence => true

  has_many :ssrows
end
