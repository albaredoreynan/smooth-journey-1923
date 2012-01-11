class PurchaseItem < ActiveRecord::Base
  attr_accessor :vat_amount, :net_amount
  attr_accessor :convert_unit

  composed_of :qty, :mapping => [%w(quantity quantity), %w(unit_id symbol)],
                    :class_name => 'Quantity',
                    :constructor => Proc.new {|quantity, unit_id| Quantity.new(quantity, Unit.find(unit_id).symbol) }

  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id,     :presence => true
  validates :amount,      :presence => true
  validates :quantity,    :presence => true, :numericality => true

  scope :start_date, lambda {|date| joins(:purchase).where('purchase_date >= ?', date) unless date.nil?}
  scope :end_date, lambda {|date| joins(:purchase).where('purchase_date <= ?', date) unless date.nil?}

  def self.search_by_date(beginning, ending)
    start_date(beginning).end_date(ending)
  end

  def purchase_amount
    vat_type == 'VAT-Exclusive' ? amount + vat_amount : amount
  end

  def vat_type
    purchase.vat_type
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
    @convert_unit ? qty.to(item.unit.symbol).value : self[:quantity]
  end

  def unit_cost
    (self[:amount] / quantity)
  end

  def subcategory_name
    item.subcategory_name
  end
end
