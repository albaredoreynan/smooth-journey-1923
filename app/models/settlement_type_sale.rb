class SettlementTypeSale < ActiveRecord::Base
  belongs_to :sale
  belongs_to :settlement_type

  validates :amount, :numericality => true, :allow_nil => true
end
