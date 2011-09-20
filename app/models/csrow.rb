class Csrow < ActiveRecord::Base
  belongs_to :sale
  has_one :category
  
  validates_numericality_of :cs_amount
  
  def self.category_sales_sum(date, category)
    joins('JOIN sales ON csrows.sale_id = sales.id').where("date = ? and category_id = ?", date,category).map(&:cs_amount).sum    
  end
  
  def self.total_category_sales_sum(category)
    where("category_id = ?", category).map(&:cs_amount).sum    
  end

end
