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
  validate :check_total

  scope :start_date, lambda {|date| where('date >= ?', date) unless date.blank?}
  scope :end_date, lambda {|date| where('date <= ?', date) unless date.blank?}

  has_many :category_sales
  has_many :settlement_type_sales
  belongs_to :employee

  accepts_nested_attributes_for :category_sales
  accepts_nested_attributes_for :settlement_type_sales

  def category_total
    category_sales.map(&:amount).reject(&:nil?).sum
  end

  def settlement_type_total
    settlement_type_sales.map(&:amount).reject(&:nil?).sum
  end

  def self.search_by_date(starting, ending)
    finder = start_date(starting)
    finder = finder.end_date(ending)
    return finder
  end

  def self.total_void
    all.map(&:void).sum
  end

  def self.total_vat
    all.map(&:vat).sum
  end

  def self.total_service_charge
    all.map(&:service_charge).sum
  end

  def self.total_revenue
    all.map(&:total_revenue_cs).sum
  end

  def self.total_customer_count
    all.map(&:customer_count).sum
  end

  def self.total_transaction_count
    all.map(&:transaction_count).sum
  end

  def self.total_gross_total_ss
    all.map(&:gross_total_ss).sum
  end

  def self.total_net_total_ss
    all.map(&:net_total_ss).sum
  end

  def self.gross_sales_sum(date)
    where("date = ?",date).map(&:total_amount_cs).sum
  end

  private
  def check_total
    errors.add(:base, "The total doesn't add up.") if category_total != settlement_type_total
  end
end
