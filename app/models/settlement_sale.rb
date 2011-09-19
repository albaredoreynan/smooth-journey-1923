class SettlementSale < ActiveRecord::Base
    has_one :settlement_type
    belongs_to :employee
    has_many :ssrows
    
    accepts_nested_attributes_for :ssrows
end
