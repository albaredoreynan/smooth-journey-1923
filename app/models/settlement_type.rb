class SettlementType < ActiveRecord::Base

  validates :st_name, :presence => true

  has_many :ssrows
end
