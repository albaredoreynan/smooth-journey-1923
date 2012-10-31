class Employee < ActiveRecord::Base

  belongs_to :branch
  #belongs_to :job
  #belongs_to :department
  #has_many :settlement_sales, :dependent => :destroy
  #has_many :categorysales, :dependent => :destroy

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  def full_name
    "#{self[:first_name]} #{self[:last_name]}"
  end

end
