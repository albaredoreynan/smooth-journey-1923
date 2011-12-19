class Purchase < ActiveRecord::Base

  attr_accessor :vat_amount, :net_amount

  #validates :supplier_id, :presence => true
  #validates :branch_id, :presence => true
  #validates :invoice_id, :presence => true, :numericality => true

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

  def amount; end
  def vat_type; end

end
