pdf.start_new_page
pdf.text "Daily Sales Reports" , :style => :bold
row5 = []
          
row5 << ['Concept','Branch','Date']
row5 << [@sale.branch.restaurant.name, @sale.branch.location, @sale.sale_date.strftime("%-d-%b-%Y") ]

pdf.move_down 10
pdf.font_size 7

pdf.table row5,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 120, 1 => 120, 2 => 120}

pdf.move_down 10
  
row1 = []

row2 = []

row3 = []

row4 = []

row1 << ['Sales By Category','','']
  

  sale_categories_percentage = Array.new
  @sale.sale_category_rows.each do |scr|
    amount_percentage = scr.amount.to_f.percent_of(@sale.net_sales)
    sale_categories_percentage << amount_percentage
    row1 << [scr.category.name, number_to_currency(scr.amount, :unit => peso_sign), number_to_percentage(amount_percentage, :precision => 2)]
  end
  
  row1 << ['Net Sales', number_to_currency(@sale.net_sales, :unit => peso_sign), number_to_percentage(sale_categories_percentage.inject(:+), :precision => 2)]
  
  revenues_percentage = Array.new
  vat_percentage = @sale.vat.percent_of(@sale.total_revenues)
  revenues_percentage << vat_percentage
  row1 << ['VAT', number_to_currency(@sale.vat, :unit => peso_sign), number_to_percentage(vat_percentage, :precision => 2)]
  
  service_charge_percentage = @sale.service_charge.percent_of(@sale.total_revenues)
  revenues_percentage << service_charge_percentage
  row1 << ['Service Charge', number_to_currency(@sale.service_charge, :unit => peso_sign), number_to_percentage(service_charge_percentage, :precision => 2)]
        
  row1 << ['Total Revenues', number_to_currency(@sale.total_revenues, :unit => peso_sign), number_to_percentage(revenues_percentage.inject(:+), :precision => 2) ]
  
pdf.table row1,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 120, 1 => 120, 2 => 120}
  
pdf.move_down 10

  row2 << ['Sale by Settlement Type','','']

  settlement_type_percentage = Array.new
  @sale.settlement_type_sales.each do |sts|
  
    sts_amount_percentage = sts.amount.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << sts_amount_percentage        
    
    row2 << [sts.settlement_type.name, number_to_currency(sts.amount, :unit => peso_sign), number_to_percentage(sts_amount_percentage, :precision => 2) ]
  end
  
    cash_in_percentage = (@sale.cash_in_drawer / @sale.total_settlement_type_sales) * 100
    settlement_type_percentage << cash_in_percentage
    row2 << ['Cash', number_to_currency(@sale.cash_in_drawer, :unit => peso_sign), number_to_percentage(cash_in_percentage, :precision => 2) ]
    
    gc_redeemed_percentage = @sale.gc_redeemed.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << gc_redeemed_percentage    
    row2 << ['GC Redeemed', number_to_currency(@sale.gc_redeemed, :unit => peso_sign), number_to_percentage(gc_redeemed_percentage, :precision => 2)]
    
    delivery_sale_percentage = @sale.delivery_sales.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << delivery_sale_percentage
    row2 << ['Delivery', number_to_currency(@sale.delivery_sales, :unit => peso_sign), number_to_percentage(delivery_sale_percentage, :precision => 2)]
    
    row2 << ['Total', number_to_currency(@sale.total_settlement_type_sales, :unit => peso_sign), number_to_percentage(settlement_type_percentage.inject(:+), :precision => 2)]
    
pdf.table row2,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 120, 1 => 120, 2 => 120}
  
pdf.move_down 10

    row3 << ['Statistics', '']
        
    row3 << ['Customer Count', @sale.customer_count]
    row3 << ['Per Person Average', @sale.per_person_ave]
    row3 << ['Transaction Count', @sale.transaction_count]
    row3 << ['Per Trans Average', @sale.per_trans_ave]

pdf.table row3,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 180, 1 => 180} 
  
pdf.move_down 10          
          
    row4 << ['Cash For Deposit', '']
    row4 << ['Cash in Drawer', number_to_currency(@sale.cash_in_drawer, :unit => peso_sign)]
    row4 << ['GC Sales', number_to_currency(@sale.gc_sales, :unit => peso_sign)]
    row4 << ['Other Income', number_to_currency(@sale.other_income, :unit => peso_sign)]
    row4 << ['Total', number_to_currency(@sale.cash_for_deposit, :unit => peso_sign)]
        
pdf.table row4,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 180, 1 => 180}
   
pdf.font_size 8

pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
