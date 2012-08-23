class Sale < ActiveRecord::Base

  validates :branch_id, :presence => true
  validates :customer_count, :presence => true
  validates :transaction_count, :presence => true
  validates :vat, :presence => true
  validates :sale_date, :presence => true
  # validate :category_and_settlement_totals_should_be_equal
  # validate :cash_for_deposit_totals_should_be_equal

  default_scope :order => 'sale_date DESC'

  scope :start_date, lambda {|date| where('sale_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('sale_date <= ?', date) unless date.blank?}

  has_many :settlement_type_sales, :dependent => :destroy 
  has_many :categories,
    :through => :sale_category_rows,
    :source => :category,
    :class_name => 'SaleCategory'
  has_many :sale_category_rows, :dependent => :destroy 
  has_many :sale_servers, :dependent => :destroy 
  belongs_to :branch 

  accepts_nested_attributes_for :settlement_type_sales
  accepts_nested_attributes_for :sale_category_rows
  accepts_nested_attributes_for :sale_servers

  def category_total
    sale_category_rows.map(&:amount).reject(&:nil?).inject(:+).to_f || 0
  end

  def settlement_type_total
    settlement_type_sales.map(&:amount).reject(&:nil?).inject(:+) || 0
  end

  def server_sale_total
    sale_servers.map(&:amount).reject(&:nil?).inject(:+) || 0
  end

  def net_sales
    category_total
  end

  def total_revenues
    category_total + vat + service_charge
  end

  def total_settlement_type_sales
    #settlement_type_total + gc_redeemed + delivery_sales 
    settlement_type_total + gc_redeemed + delivery_sales + cash_in_drawer 
  end

  def cash_for_deposit
    cash_in_drawer + gc_sales + other_income
    #gc_sales + other_income
  end

  def per_person_ave
    (net_sales / customer_count).round(2) unless customer_count == 0
  end

  def per_trans_ave
    (net_sales / transaction_count).round(2) unless transaction_count == 0
  end

  def self.search_by_date(starting, ending)
    finder = start_date(starting)
    finder = finder.end_date(ending)
    return finder
  end

  def month_to_date
    Sale.find(:all, :conditions => ['sale_date >= ? and sale_date <= ?', Date.today.beginning_of_month, Date.today] )
  end
  
  def month_to_date_customer_count
    month_to_date.map(&:customer_count).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_transaction_count
    month_to_date.map(&:transaction_count).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_delivery_sales
    month_to_date.map(&:delivery_sales).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_cash_in_drawer
    month_to_date.map(&:cash_in_drawer).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_gc_sales
    month_to_date.map(&:gc_sales).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_other_income
    month_to_date.map(&:other_income).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_vat
    month_to_date.map(&:vat).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_gc_redeemed
    month_to_date.map(&:gc_redeemed).reject(&:nil?).inject(:+) || 0
  end
  
  def month_to_date_service_charge
    month_to_date.map(&:service_charge).reject(&:nil?).inject(:+) || 0
  end

  def month_to_date_cash_for_deposit
    month_to_date_cash_in_drawer + month_to_date_gc_sales + month_to_date_other_income
  end
  private
  def category_and_settlement_totals_should_be_equal
    unless total_revenues == total_settlement_type_sales && server_sale_total == cash_for_deposit
      errors.add(:base, 'category sale and settlement type sales should be equal')
    end
  end
  
  def cash_for_deposit_totals_should_be_equal
    unless server_sale_total == cash_for_deposit
      errors.add(:base, 'server sale and cash for deposit should be equal')
    end
  end
end
