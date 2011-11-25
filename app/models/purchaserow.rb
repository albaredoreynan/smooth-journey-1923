class Purchaserow < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :item
  belongs_to :unit

  validates :item_id, :presence => true
  validates :amount, :presence => true
  validates :quantity, :presence => true, :numericality => true
  validates :unit_cost, :presence => true, :numericality => true
  validates :vat_type, :presence => true

  def vat_amount
    case vat_type
    when 'VAT-Inclusive'
      amount - (amount / 1.12).round(2)
    when 'VAT-Exclusive'
      amount * 0.12
    when 'VAT-Exempted'
      0
    end
  end

  def net_amount
    if vat_type == 'VAT-Inclusive'
      (amount - vat_amount).round(2)
    else
      amount
    end
  end
end
