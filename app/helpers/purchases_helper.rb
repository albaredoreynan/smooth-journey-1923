module PurchasesHelper
  def purchase_item_unit_cost(purchase_item)
    unit_cost = number_to_currency(purchase_item.unit_cost, :unit => peso_sign)
    raw "#{unit_cost}/#{purchase_item.unit_name}"
  end
end
