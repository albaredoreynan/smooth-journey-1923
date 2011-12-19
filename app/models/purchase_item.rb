class PurchaseItem < ActiveRecord::Base
  attr_accessor :vat_amount, :net_amount

  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id,     :presence => true
  validates :amount,      :presence => true
  validates :quantity,    :presence => true, :numericality => true
  #validates :unit_cost,   :presence => true, :numericality => true
  validates :vat_type,    :presence => true,
                          :inclusion => { :in => %w{VAT-Inclusive VAT-Exclusive VAT-Exempted} }

  def vat_amount
    case vat_type
    when 'VAT-Inclusive'
      amount - (amount / 1.12).round(2)
    when 'VAT-Exclusive'
      amount * 0.12
    when 'VAT-Exempted'
      0
    end
  end

  def net_amount
    vat_type == 'VAT-Inclusive' ? (amount - vat_amount).round(2) : amount
  end

  def item_name
    self.item.name
  end

  def unit_name
    self.unit.name
  end

  def unit_cost
    self[:amount] / self[:quantity]
  end
end
