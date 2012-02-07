module Taxable
  attr_accessor :vat_amount, :net_amount

  def vat_amount
    case vat_type
    when 'VAT-Inclusive'
      amount - (amount / 1.12)
    when 'VAT-Exclusive'
      amount * 0.12
    when 'VAT-Exempted'
      0
    end
  end

  def net_amount
    vat_type == 'VAT-Inclusive' ? (amount - vat_amount) : amount
  end

  def purchase_amount
    vat_type == 'VAT-Exclusive' ? amount + vat_amount : amount
  end
end
