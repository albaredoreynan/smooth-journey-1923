module Taxable
  extend ActiveSupport::Concern

  attr_accessor :vat_amount, :net_amount

  included do
    validates :vat_type,
      :inclusion => { :in => %w(VAT-Exclusive VAT-Inclusive VAT-Exempted) }
  end

  def vat_amount
    case vat_type
    when 'VAT-Inclusive'
      amount - (amount / 1.12)
    when 'VAT-Exclusive'
      (amount * 1.12) - amount
    when 'VAT-Exempted'
      0
    end
  end

  def net_amount
    if vat_type == 'VAT-Inclusive'
      (amount - vat_amount)
    else
      if vat_type == 'VAT-Exclusive'
        (amount + vat_amount)
      else
        amount
      end
    end
  end

  def purchase_amount
    if vat_type == 'VAT-Exclusive'
      (amount - vat_amount)
    else
      if vat_type == 'VAT-Inclusive'
        (amount + vat_amount)
      else
        amount
      end
    end
  end
  
end
