
class Categorysale < ActiveRecord::Base
  has_one :category
  has_one :employee
  has_many :category_sales

  accepts_nested_attributes_for :category_sales
  validates_presence_of :employee_id
  validates_numericality_of :vat
  validates_numericality_of :void
  validates_numericality_of :servicecharge
  validates_numericality_of :cs_revenue
  validates_numericality_of :customer_count
  validates_numericality_of :transaction_count
  validates_numericality_of :cs_total_amount
  validates_presence_of :cs_revenue
  validates_uniqueness_of :cs_date

  def self.search_by_date(start_date,end_date)
    where("cs_date >= ? and cs_date <= ?",start_date,end_date).all
  end

end
