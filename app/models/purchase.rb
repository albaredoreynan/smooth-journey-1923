class Purchase < ActiveRecord::Base

  belongs_to :supplier
  belongs_to :branch
  has_many :purchase_items, :dependent => :destroy

  accepts_nested_attributes_for :purchase_items #, :reject_if => lambda { |a| a[:item_id].blank? }

  def self.search_by_date(start_date, end_date)
    if start_date && end_date.blank?
      where('purchase_date >= ?', start_date)
    elsif start_date.blank? && end_date
      where('purchase_date <= ?', end_date)
    else
      where('purchase_date >= ? AND purchase_date <= ?', start_date, end_date)
    end
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
    supplier.name || ''
  end
end
