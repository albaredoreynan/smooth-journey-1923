class Supplier < ActiveRecord::Base

  validates :supplier_name, :presence => true

  belongs_to :branch
end
