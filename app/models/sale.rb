class Sale < ActiveRecord::Base
  has_many :csrows
  has_many :ssrows
  belongs_to :employee
  
  accepts_nested_attributes_for :csrows
  accepts_nested_attributes_for :ssrows
  
  def self.search_date_range(from,to)
    where("date >= ? and date <= ?",from,to)  
  end
  
  def self.search_by_employee(employee_id)
    where("employee_id = ?",employee_id)  
  end

  def self.total_void()
    all.map(&:void).sum    
  end
  
  def self.total_vat()
    all.map(&:vat).sum    
  end
  
  def self.total_service_charge()
    all.map(&:service_charge).sum    
  end  
  
  def self.total_revenue()
    all.map(&:total_revenue_cs).sum    
  end  
  
  def self.total_customer_count()
    all.map(&:customer_count).sum    
  end    
  
  def self.total_transaction_count()
    all.map(&:transaction_count).sum    
  end 
  
  def self.total_gross_total_ss()
    all.map(&:gross_total_ss).sum    
  end    
  
  def self.total_net_total_ss()
    all.map(&:net_total_ss).sum    
  end
  
  def self.gross_sales_sum(date)
    where("date = ?",date).map(&:total_amount_cs).sum    
  end
             
end
