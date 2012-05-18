pdf.start_new_page 
pdf.text "Daily Sales Reports" , :style => :bold
pdf.move_down 10
pdf.font_size 7

row1 = []

row2 = []

row3 = []

row4 = []

row1 << ['Sales By Category','','']
  

  sale_categories_percentage = Array.new
  @sale.sale_category_rows.each do |scr|
    amount_percentage = scr.amount.to_f.percent_of(@sale.net_sales)
    sale_categories_percentage << amount_percentage
    row1 << [scr.category.name, scr.amount, number_to_percentage(amount_percentage)]
  end
  
  row1 << ['Net Sales', @sale.net_sales, number_to_percentage(sale_categories_percentage.inject(:+))]
  
  revenues_percentage = Array.new
  vat_percentage = @sale.vat.percent_of(@sale.total_revenues)
  revenues_percentage << vat_percentage
  row1 << ['VAT', @sale.vat, number_to_percentage(vat_percentage)]
  
  service_charge_percentage = @sale.service_charge.percent_of(@sale.total_revenues)
  revenues_percentage << service_charge_percentage
  row1 << ['Service Charge', @sale.service_charge, number_to_percentage(service_charge_percentage)]
        
  row1 << ['Total Revenues', @sale.total_revenues, number_to_percentage(revenues_percentage.inject(:+)) ]
  
pdf.table row1,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]
  
pdf.move_down 10

  row2 << ['Sale by Settlement Type','','']

  settlement_type_percentage = Array.new
  @sale.settlement_type_sales.each do |sts|
  
    sts_amount_percentage = sts.amount.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << sts_amount_percentage        
    
    row2 << [sts.settlement_type.name, sts.amount, number_to_percentage(sts_amount_percentage) ]
  end
  
    gc_redeemed_percentage = @sale.gc_redeemed.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << gc_redeemed_percentage    
    row2 << ['GC Redeemed', @sale.gc_redeemed, number_to_percentage(gc_redeemed_percentage)]
    
    delivery_sale_percentage = @sale.delivery_sales.percent_of(@sale.total_settlement_type_sales)
    settlement_type_percentage << delivery_sale_percentage
    row2 << ['Delivery', @sale.delivery_sales, number_to_percentage(delivery_sale_percentage)]
    
    row2 << ['Total', @sale.total_settlement_type_sales, number_to_percentage(settlement_type_percentage.inject(:+))]
    
pdf.table row2,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]
  
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
  :row_colors => ["d2e3ed", "FFFFFF"]
  
pdf.move_down 10          
          
    row4 << ['Cash For Deposit', '']
    row4 << ['Cash in Drawer', @sale.cash_in_drawer]
    row4 << ['GC Sales', @sale.gc_sales]
    row4 << ['Other Income', @sale.other_income]
    row4 << ['Total', @sale.cash_for_deposit]
        
pdf.table row4,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]
  
pdf.font_size 8

pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
