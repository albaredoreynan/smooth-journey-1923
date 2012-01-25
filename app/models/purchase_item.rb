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
  validates :amount,      :presence => true, :numericality => true
  validates :quantity,    :presence => true, :numericality => true
  validates :vat_type,    :presence => true,
                          :inclusion => { :in => %w(VAT-Exclusive VAT-Inclusive VAT-Exempted) }

  default_scope joins(:purchase).order('purchase_date DESC')

  scope :start_date, lambda {|date| joins(:purchase).where('purchases.purchase_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| joins(:purchase).where('purchases.purchase_date <= ?', date) unless date.blank?}
  scope :search_by_supplier, lambda {|keyword| joins(:purchase => :supplier).where('suppliers.name ILIKE ?', "#{keyword}%") unless keyword.blank?}
  scope :search_by_invoice_number, lambda {|keyword| joins(:purchase).where('purchases.invoice_number ILIKE ?', "#{keyword}") unless keyword.blank?}
  scope :search_by_item_name, lambda {|keyword| joins(:item).where('items.name ILIKE ?', "%#{keyword}%") unless keyword.blank?}
  scope :search_by_subcategory, lambda {|keyword| joins(:item => :subcategory).where('subcategories.name ILIKE ?', "%#{keyword}%") unless keyword.blank?}

  def self.search(queries)
    finder =        search_by_supplier(queries[:supplier])
    finder = finder.search_by_invoice_number(queries[:invoice_number])
    finder = finder.search_by_item_name(queries[:item])
    finder = finder.search_by_subcategory(queries[:subcategory])
    finder = finder.start_date(queries[:start_date]).end_date(queries[:end_date])
    return finder
  end

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
    @convert_unit ? qty.to(item.unit.symbol).value : self[:quantity]
  end

  def unit_cost
    (self[:amount] / quantity)
  end

  def subcategory_name
    item.subcategory_name
  end
end
