class Sale < ActiveRecord::Base

  validates_presence_of :date
  validates_presence_of :customer_count
  validates_presence_of :transaction_count
  validates_presence_of :delivery_pta
  validates_presence_of :delivery_sales
  validates_presence_of :delivery_tc
  validates_presence_of :dinein_cc
  validates_presence_of :dinein_ppa
  validates_presence_of :dinein_pta
  validates_presence_of :dinein_tc
  validates_presence_of :gross_total_ss
  validates_presence_of :net_total_ss
  validates_presence_of :service_charge
  validates_presence_of :takeout_pta
  validates_presence_of :takeout_tc
  validates_presence_of :total_amount_cs
  validates_presence_of :total_revenue_cs
  validates_presence_of :vat
  validates_presence_of :void

  default_scope :order => 'date DESC'

  scope :start_date, lambda {|date| where('date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('date <= ?', date) unless date.blank?}

  has_many :settlement_type_sales
  has_many :categories,
    :through => :sale_category_rows,
    :source => :category,
    :class_name => 'SaleCategory'
  has_many :sale_category_rows
  belongs_to :employee
  belongs_to :branch

  accepts_nested_attributes_for :settlement_type_sales
  accepts_nested_attributes_for :sale_category_rows

  def category_total
    sale_category_rows.map(&:amount).reject(&:nil?).inject(:+).to_f
  end

  def settlement_type_total
    settlement_type_sales.map(&:amount).reject(&:nil?).inject(:+)
  end

  def self.search_by_date(starting, ending)
    finder = start_date(starting)
    finder = finder.end_date(ending)
    return finder
  end
end
