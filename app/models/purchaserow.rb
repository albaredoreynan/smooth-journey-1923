class Purchaserow < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id, :presence => true
  validates :amount, :presence => true
  validates :quantity, :presence => true, :numericality => true
  validates :unit_cost, :presence => true, :numericality => true
  validates :vat_type, :presence => true
  #validates :vat_amount, :presence => true
  #validates :net_amount, :presence => true
end
