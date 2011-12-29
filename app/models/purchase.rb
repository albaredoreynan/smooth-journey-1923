class Purchase < ActiveRecord::Base

  belongs_to :supplier
  belongs_to :branch
  has_many :purchase_items, :dependent => :destroy

  scope :start_date, lambda {|date| where('purchase_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('purchase_date <= ?', date) unless date.blank?}
  scope :non_draft, where(:save_as_draft => false)

  accepts_nested_attributes_for :purchase_items, :reject_if => proc {|attr| attr[:item_name].blank?}

  def self.search_by_date(starting, ending)
    finder = start_date(starting)
    finder = finder.end_date(ending)
    return finder
  end

  def self.search_by_supplier(supplier_id)
    where("supplier_id = ?", supplier_id)
  end

  def self.search_by_category(category_id)
    where("category_id = ?", category_id)
  end

  #def total_amount_period()

  #end

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
