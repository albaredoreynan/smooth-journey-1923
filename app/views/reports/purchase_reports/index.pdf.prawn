pdf.start_new_page :layout => :landscape
pdf.text "Purchase Report From #{@start_date} To #{@end_date}" , :style => :bold 
pdf.move_down 10
pdf.font_size 7

rows = []
rows2 = []

subtotal = 0
grand_total = 0

purchase_item_headers = ['Item Subcategory','Item', 'Invoice number', 'Supplier name', 'Purchase date', 'Particulars', 'Qty', 'Unit', 'Unit cost', 'VAT', 'Purchase amount', 'Net amount']
rows << purchase_item_headers

@purchase_items.each do |subcategory, purchase_items|
subtotal = purchase_items.map(&:net_amount).inject(:+)
grand_total += subtotal

  rows << [subcategory.name, '','','','','','','','','','',subtotal]
        
end

rows << ['Grand Total','','','','','','','','','','', grand_total]

pdf.table rows,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]

pdf.font_size 8
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
    
    
