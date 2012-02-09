class PurchaseItem < ActiveRecord::Base
  include Taxable

  attr_accessor :convert_unit

  composed_of :qty, :mapping => [%w(quantity quantity), %w(unit_id symbol)],
                    :class_name => 'Quantity',
                    :constructor => Proc.new {|quantity, unit_id| Quantity.new(quantity, Unit.find(unit_id)) }

  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id,     :presence => true
  validates :amount,      :presence => true, :numericality => true
  validates :quantity,    :presence => true, :numericality => true
  validates :unit_id,     :presence => true
  validate :only_allow_unit_with_conversion_to_base_unit

  default_scope joins(:purchase).order('purchase_date DESC')

  scope :start_date, lambda {|date| joins(:purchase).where('purchases.purchase_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| joins(:purchase).where('purchases.purchase_date <= ?', date) unless date.blank?}
  scope :search_by_supplier, lambda {|keyword| joins(:purchase => :supplier).where('suppliers.name ILIKE ?', "#{keyword}%") unless keyword.blank?}
  scope :search_by_invoice_number, lambda {|keyword| joins(:purchase).where('purchases.invoice_number ILIKE ?', "#{keyword}") unless keyword.blank?}
  scope :search_by_item_name, lambda {|keyword| joins(:item).where('items.name ILIKE ?', "%#{keyword}%") unless keyword.blank?}
  scope :search_by_subcategory, lambda {|keyword| joins(:item => :subcategory).where('subcategories.name ILIKE ?', "%#{keyword}%") unless keyword.blank?}

  delegate :name, :to => :item, :prefix => true
  delegate :name, :symbol, :to => :unit, :prefix => true
  delegate :available_units, :to => :item

  def self.search(queries)
    finder =        search_by_supplier(queries[:supplier])
    finder = finder.search_by_invoice_number(queries[:invoice_number])
    finder = finder.search_by_item_name(queries[:item])
    finder = finder.search_by_subcategory(queries[:subcategory])
    finder = finder.start_date(queries[:start_date]).end_date(queries[:end_date])
    return finder
  end

  def quantity
    @convert_unit ? qty.to(item.unit).value : self[:quantity]
  end

  def unit_cost
    (self[:amount] / quantity)
  end

  def subcategory_name
    item.subcategory_name
  end

  private
  def only_allow_unit_with_conversion_to_base_unit
    return if item.nil?
    unless available_units.map(&:id).reject(&:nil?).include?(unit_id)
      errors.add(:unit_id, 'does not have a conversion to base unit')
    end
  end
end
