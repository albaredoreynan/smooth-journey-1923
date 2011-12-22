class Purchase < ActiveRecord::Base

  belongs_to :supplier
  belongs_to :branch
  has_many :purchase_items, :dependent => :destroy

  scope :start_date, lambda {|date| where('purchase_date >= ?', date)}
  scope :end_date, lambda {|date| where('purchase_date <= ?', date)}
  scope :non_draft, where(:save_as_draft => false)

  accepts_nested_attributes_for :purchase_items #, :reject_if => lambda { |a| a[:item_id].blank? }

  def self.search_by_date(starting, ending)
    start_date(starting).end_date(ending)
  end

  def self.search_by_supplier(supplier_id)
    where("supplier_id = ?", supplier_id)
  end

  def self.search_by_category(category_id)
    where("category_id = ?", category_id)
  end

  def amount
    purchase_items.map(&:amount).inject(:+)
  end

  def net_amount
    purchase_items.map(&:net_amount).inject(:+)
  end

  def vat_amount
    purchase_items.map(&:vat_amount).inject(:+)
  end

  def supplier_name
    supplier.name if supplier
  end

  def branch_location
    branch.location if branch
  end
end
