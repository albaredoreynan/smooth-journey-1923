class Employee < ActiveRecord::Base
  belongs_to :branch
  has_many :settlement_sales
  has_many :categorysales
  
  def name_with_initial
    "#{employee_firstName} #{employee_lastName}"
  end

end
