pdf.start_new_page
pdf.text "Purchase Report From #{@start_date} To #{@end_date}" , :style => :bold 
pdf.move_down 10
pdf.font_size 7

rows = []
grand_total = 0

purchase_item_headers = ['Item', 'Invoice number', 'Supplier name', 'Purchase
  date', 'Qty', 'Unit', 'Unit cost', 'VAT', 'Purchase amount', 'Net amount']
rows << purchase_item_headers

@purchase_items.each do |subcategory, purchase_items|
  purchase_items.each do |purchase_item|
    grand_total += purchase_items.map(&:net_amount).inject(:+)
    rows << [purchase_item.item.name,
    purchase_item.purchase.invoice_number,
    purchase_item.purchase.supplier_name,
    purchase_item.purchase.purchase_date,
    purchase_item.quantity,
    purchase_item.item.unit_name,
    number_to_currency(purchase_item.unit_cost, :unit => peso_sign),
    number_to_currency(purchase_item.vat_amount, :unit => peso_sign),
    number_to_currency(purchase_item.purchase_amount, :unit => peso_sign),
    number_to_currency(purchase_item.net_amount, :unit => peso_sign)]
  end
end

pdf.table ( rows ) do
  header = true
  columns(4).align = :right
  columns(6..9).align = :right
end
pdf.move_down 20
pdf.text "Total: #{number_to_currency(grand_total, :unit => peso_sign)}"
