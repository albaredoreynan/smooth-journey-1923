class Purchase < ActiveRecord::Base

  validates :supplier_id, :presence => true
  validates :branch_id, :presence => true
  validates :invoice_id, :presence => true, :numericality => true

  belongs_to :supplier
  belongs_to :branch
  has_many :purchaserows, :dependent => :destroy

  accepts_nested_attributes_for :purchaserows #, :reject_if => lambda { |a| a[:item_id].blank? }
  #accepts_nested_attributes_for :purchaserows, :reject_if => lambda { |a| a.all? {|k,v| v.blank? } }
  #accepts_nested_attributes_for :purchaserows, :reject_if => :all_blank


  def self.search_by_date(start_date, end_date)
    if start_date.is_a?(Hash) && end_date.is_a?(Hash)
      start_date = Date.parse(start_date.to_a.sort.collect{|c| c[1]}.join('-'))
      end_date = Date.parse(end_date.to_a.sort.collect{|c| c[1]}.join('-'))
    end
    where("purchase_date >= ? and purchase_date <= ? and (purchase_date is not null)" , start_date, end_date)
  end

  def self.search_by_supplier(supplier_id)
    where("supplier_id = ?", supplier_id)
  end

  def self.search_by_category(category_id)
    where("category_id = ?", category_id)
  end
end
