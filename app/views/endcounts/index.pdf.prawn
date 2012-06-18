pdf.start_new_page 
pdf.text "Inventory Item List" , :style => :bold
pdf.move_down 10
pdf.font_size 11

rows = []

headers = ['Subcategory', 'Item', 'Unit', 'Quantity', 'Count']

rows << headers

@items.each do |item|
  rows << [ item.subcategory_name, item.name, item.unit_name, '', '']
end

pdf.table rows,
  :border_style => :grid,
  :font_size => 11,
  :position => :left,
  :row_colors => ["FFFFFF", "FFFFFF"],
  :column_widths => { 0 => 80, 1 => 120, 2 => 60, 3 => 180, 4 => 50 }

pdf.font_size 8
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
