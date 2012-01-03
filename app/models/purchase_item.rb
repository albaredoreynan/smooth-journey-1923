class PurchaseItem < ActiveRecord::Base
  attr_accessor :vat_amount, :net_amount
  attr_accessor :convert_unit

  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id,     :presence => true
  validates :amount,      :presence => true
  validates :quantity,    :presence => true, :numericality => true
  validates :vat_type,    :presence => true,
                          :inclusion => { :in => %w{VAT-Inclusive VAT-Exclusive VAT-Exempted} }

  def purchase_amount
    vat_type == 'VAT-Exclusive' ? amount + vat_amount : amount
  end

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
    item.name if item
  end

  def unit_name
    unit.name if unit
  end

  def unit_symbol
    unit.symbol
  end

  def quantity
    @convert_unit ? convert(self[:quantity]) : self[:quantity]
  end

  def unit_cost
    (self[:amount] / quantity)
  end

  private
  def convert(quantity)
    converter = Conversion.where(:bigger_unit_id => self[:unit_id], :smaller_unit_id => item.unit_id).first
    return quantity if converter.nil?
    quantity * converter.conversion_factor
  end
end
