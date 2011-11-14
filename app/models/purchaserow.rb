class Purchaserow < ActiveRecord::Base
  belongs_to :purchase

  validates :inventoryitem_id, :presence => true
  validates :purchase_amount, :presence => true
  validates :purchase_quantity, :presence => true, :numericality => true
  validates :vat_type, :presence => true
  validates :purchase_unitCost, :presence => true, :numericality => true
  #validates :vat_amount, :presence => true
  #validates :net_amount, :presence => true
end
