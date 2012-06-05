class SettlementSale < ActiveRecord::Base
    has_one :settlement_type, :dependent => :destroy
    belongs_to :employee
    has_many :settlement_type_sales, :dependent => :destroy

    accepts_nested_attributes_for :settlement_type_sales
end
