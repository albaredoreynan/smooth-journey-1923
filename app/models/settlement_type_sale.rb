class SettlementTypeSale < ActiveRecord::Base
  belongs_to :sale
  belongs_to :settlement_type

  validates_numericality_of :ss_amount

  def self.settlement_sales_sum(date, settlementtype)
    joins('JOIN sales ON ssrows.sale_id = sales.id').where("date = ? and settlement_type_id = ?", date,settlementtype).map(&:ss_amount).sum
  end

  def self.total_settlement_sales_sum(settlementtype)
    where("settlement_type_id = ?", settlementtype).map(&:ss_amount).sum
  end

end
