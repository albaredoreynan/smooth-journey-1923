class Sale < ActiveRecord::Base

  validates :customer_count, :presence => true
  validates :transaction_count, :presence => true
  validates :vat, :presence => true
  validates :sale_date, :presence => true

  default_scope :order => 'sale_date DESC'

  scope :start_date, lambda {|date| where('sale_date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('sale_date <= ?', date) unless date.blank?}

  has_many :settlement_type_sales
  has_many :categories,
    :through => :sale_category_rows,
    :source => :category,
    :class_name => 'SaleCategory'
  has_many :sale_category_rows
  belongs_to :branch

  accepts_nested_attributes_for :settlement_type_sales
  accepts_nested_attributes_for :sale_category_rows

  def category_total
    sale_category_rows.map(&:amount).reject(&:nil?).inject(:+).to_f
  end

  def settlement_type_total
    settlement_type_sales.map(&:amount).reject(&:nil?).inject(:+) || 0
  end

  def net_sales
    category_total
  end

  def total_revenues
    category_total + vat + service_charge
  end

  def total_settlement_type_sales
    settlement_type_total + gc_redeemed + delivery_sales
  end

  def cash_for_deposit
    cash_in_drawer + gc_sales + other_income
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
end
