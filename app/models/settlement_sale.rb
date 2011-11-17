class SettlementSale < ActiveRecord::Base
    has_one :settlement_type
    belongs_to :employee
    has_many :settlement_type_sales

    accepts_nested_attributes_for :settlement_type_sales
end
