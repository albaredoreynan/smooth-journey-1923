class SettlementTypeSale < ActiveRecord::Base
  belongs_to :sale
  belongs_to :settlement_type

  validates_numericality_of :amount

  def self.settlement_sales_sum(date, settlementtype)
    joins('JOIN sales ON settlement_type_sales.sale_id = sales.id').where("date = ? and settlement_type_id = ?", date,settlementtype).map(&:amount).sum
  end

  def self.total_settlement_sales_sum(settlementtype)
    where("settlement_type_id = ?", settlementtype).map(&:amount).sum
  end

end
