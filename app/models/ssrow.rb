class Ssrow < ActiveRecord::Base
  belongs_to :settlement_sale
  belongs_to :settlement_type
  
    validates_numericality_of :ss_amount
end
