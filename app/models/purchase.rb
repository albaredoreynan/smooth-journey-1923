class Purchase < ActiveRecord::Base
  has_many :purchaserows, :dependent => :destroy
  accepts_nested_attributes_for :purchaserows #, :reject_if => lambda { |a| a[:inventoryitem_id].blank? }
  #accepts_nested_attributes_for :purchaserows, :reject_if => lambda { |a| a.all? {|k,v| v.blank? } }
  #accepts_nested_attributes_for :purchaserows, :reject_if => :all_blank
  
  validates :supplier_id, :presence => true
  validates :branch_id, :presence => true
  validates :invoice_id, :presence => true, :numericality => true
  
  def self.search_by_date(start_date,end_date)
    where("purchase_date >= ? and purchase_date <= ?",start_date,end_date).all
  end
  
  def self.search_by_supplier(supplier_id)
    where("supplier_id = ?", supplier_id)
  end
  
  def self.search_by_category(category_id)
    where("category_id = ?", category_id)
  end
end
