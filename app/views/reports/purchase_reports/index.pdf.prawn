pdf.start_new_page :layout => :landscape
pdf.text "Purchase Report From #{@start_date} To #{@end_date}" , :style => :bold 
pdf.move_down 10
pdf.font_size 6

rows = []
rows2 = []

subtotal = 0
grand_total = 0
total_purchase_amount = 0
total_purchase_all = 0
total_purchase_amount_vat = 0
purchase_item_headers = ['Item Subcategory','Item', 'Branch', 'Invoice number', 'Supplier name', 'Purchase date', 'Particulars', 'Qty', 'Unit', 'Unit cost', 'VAT', 'Purchase amount', 'Net amount']
rows << purchase_item_headers

@purchase_items.each do |subcategory, purchase_items|
subtotal = purchase_items.map(&:net_amount).inject(:+)
grand_total += subtotal

  rows << [subcategory.name.upcase, '','','','','','','','','','','','']
    purchase_items.each do |purchase_item|
        total_purchase_amount += purchase_item.purchase_amount
        total_purchase_amount_vat += purchase_item.vat_amount
        p_amount = purchase_item.purchase_amount - purchase_item.vat_amount
        rows << ['',purchase_item.item.name,
        purchase_item.purchase.branch.location,
        purchase_item.purchase.invoice_number,
        purchase_item.purchase.supplier_name,
        purchase_item.purchase.purchase_date,
        purchase_item.particulars,
        purchase_item.quantity,
        purchase_item.item.unit_name,
        number_to_currency(purchase_item.unit_cost, :unit => peso_sign),
        number_to_currency(purchase_item.vat_amount, :unit => peso_sign),
        number_to_currency(p_amount, :unit => peso_sign),
        number_to_currency(purchase_item.net_amount, :unit => peso_sign)]
        
    end    
end
total_purchase_all =  total_purchase_amount - total_purchase_amount_vat
rows << ['Grand Total','','','','','','','','','','', number_to_currency(total_purchase_all, :unit => peso_sign), number_to_currency(grand_total, :unit => peso_sign)]

pdf.table rows,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]

pdf.font_size 6
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
    
    
