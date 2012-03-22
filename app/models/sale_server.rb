class SaleServer < ActiveRecord::Base
  belongs_to :sale
  belongs_to :server
end
