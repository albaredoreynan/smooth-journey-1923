class Csrow < ActiveRecord::Base
  belongs_to :categorysale
  has_one :category
  
    validates_numericality_of :cs_amount
end
