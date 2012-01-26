class Purchase < ActiveRecord::Base

  belongs_to :supplier
  belongs_to :branch
  belongs_to :currency
  belongs_to :created_by, :class_name => 'User'

  has_many :purchase_items, :dependent => :destroy

  default_scope order("purchase_date desc")

  scope :start_date, lambda {|date| where('purchase_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('purchase_date <= ?', date) unless date.blank?}
  scope :search_by_invoice_number, lambda {|keyword| where(['invoice_number ILIKE ?', "#{keyword}"]) unless keyword.blank?}
  scope :search_by_supplier, lambda {|keyword| joins(:supplier).where(['suppliers.name ILIKE ?', "#{keyword}%"]) unless keyword.blank?}
  scope :non_draft, where(:save_as_draft => false)
  scope :locked, where('created_at < ?', Time.now - 1.day)

  accepts_nested_attributes_for :purchase_items #, :reject_if => lambda { |a| a[:item_id].blank? }

  def self.search_by_date(starting, ending)
    finder =        start_date(starting)
    finder = finder.end_date(ending)
    return finder
  end

  def self.search(queries)
    finder =        search_by_invoice_number(queries[:invoice_number])
    finder = finder.search_by_date(queries[:start_date], queries[:end_date])
    finder = finder.search_by_supplier(queries[:supplier])
    return finder
  end

  def amount
    purchase_items.map(&:amount).inject(:+) || 0.00
  end

  def net_amount
    purchase_items.map(&:net_amount).inject(:+) || 0.00
  end

  def vat_amount
    purchase_items.map(&:vat_amount).inject(:+) || 0.00
  end

  def supplier_name
    supplier.name if supplier
  end

  def branch_location
    branch.location if branch
  end

end
