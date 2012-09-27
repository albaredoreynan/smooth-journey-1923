pdf.start_new_page
pdf.text "Directional as of #{@ending_date.strftime("%-d-%b-%Y")}" , :style => :bold
pdf.move_down 10
pdf.font_size 6

rows3 = []
headers3 = ['NET SALES(Category)', 'Amount', 'Percentage']
rows3 << headers3  
      
directional_categories_percentage = Array.new
last_year = @directional.last_year

@directional.net_sales.each do |category, net_sale|
amount_percentage = net_sale.to_f.percent_of(@directional.net_sale_total)
directional_categories_percentage << amount_percentage
rows3 << [category, number_to_currency(net_sale, :precision => 2, :unit => peso_sign), number_to_percentage(amount_percentage,  :precision => 2,)]
end

rows3 << ['Total', number_to_currency(@directional.net_sale_total, :precision => 2, :unit => peso_sign), number_to_percentage(directional_categories_percentage.inject(:+),  :precision => 2,)]

pdf.table rows3,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 130, 1 => 130, 2 => 130}
pdf.move_down 10

rows2 = []
headers2 = ['NET SALES', 'MTD', 'LAST YEAR']
rows2 << headers2
rows2 << ['Total', number_to_currency(@directional.net_sale_total, :precision => 2, :unit => peso_sign), number_to_currency(last_year.net_sale_total, :precision => 2, :unit => peso_sign)]
rows2 << ['Customer Count', number_with_precision(@directional.customer_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.customer_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Person Ave', number_to_currency(@directional.per_person_ave, :precision => 2, :unit => peso_sign), number_with_precision(last_year.per_person_ave, :precision => 2, :delimiter => ',')]
rows2 << ['Transaction Count', number_with_precision(@directional.transaction_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.transaction_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Transaction Ave', number_to_currency(@directional.per_trans_ave, :precision => 2, :unit => peso_sign), number_with_precision(last_year.per_trans_ave, :precision => 2, :delimiter => ',')]
rows2 << ['Delivery Transaction Count', number_with_precision(@directional.delivery_transaction_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.transaction_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Delivery Transaction Ave', number_to_currency(@directional.per_del_trans_ave, :precision => 2, :unit => peso_sign), number_with_precision(last_year.per_trans_ave, :precision => 2, :delimiter => ',')]
rows2 << ['Credit Card Transaction Count', number_with_precision(@directional.cc_transaction_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.transaction_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Credit Card Transaction Ave', number_to_currency(@directional.per_cc_trans_ave, :precision => 2, :unit => peso_sign), number_with_precision(last_year.per_trans_ave, :precision => 2, :delimiter => ',')]


pdf.table rows2,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 130, 1 => 130, 2 => 130}

pdf.move_down 10

rows3 = []
headers3 = ['Complimentary Analysis', 'MTD', '% To NET SALES']
rows3 << headers3

@settlement_type.each do |st| 
  settlement_type_sales_amount = st.settlement_type_sales.map(&:amount).reject(&:nil?).inject(:+).to_f || 0
  settlement_type_sales_percentage = (settlement_type_sales_amount / @directional.net_sale_total) * 100
  
  rows3 << [st.name,
           number_to_currency(st.settlement_type_sales.map(&:amount).reject(&:nil?).inject(:+).to_f || 0, :precision => 2, :unit => peso_sign),
           number_to_percentage(settlement_type_sales_percentage, :precision => 2)
          ] 
end
  
pdf.table rows3,
  :border_style => :grid,
  :font_size => 6,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 130, 1 => 130, 2 => 130}

pdf.move_down 10

rows = []
headers = ['Cost of Goods', 'Beggining', 'Purchase', 'Purchase %', 'Ending', 'COGS', 'COGS %', 'Goal %', 'VAR +/-']

rows << headers

cogs_beginning_total = Array.new
cogs_purchase_total = Array.new
cogs_purchase_percentage_total = Array.new
cogs_ending_total = Array.new
cogs_cogs_total = Array.new
cogs_cogs_percentage_total = Array.new
cogs_subcategory_goal_total = Array.new
cogs_var_percentage_total = Array.new
        
cogs_beginning_total2 = Array.new
cogs_purchase_total2 = Array.new
cogs_purchase_percentage_total2 = Array.new
cogs_ending_total2 = Array.new
cogs_cogs_total2 = Array.new
cogs_cogs_percentage_total2 = Array.new
cogs_subcategory_goal_total2 = Array.new
cogs_var_percentage_total2 = Array.new
        
@directional.cogs.each do |c|
    rows << [c.name, 
             number_with_precision(c.beginning, :precision => 2, :delimiter => ','),
             number_to_currency(c.purchase, :unit => peso_sign),
             number_to_percentage(c.purchase_perc, :precision => 2),
             number_with_precision(c.ending, :precision => 2, :delimiter => ','),
             number_to_currency(c.cogs, :unit => peso_sign),
             number_to_percentage(c.cogs_perc, :precision => 2),
             number_to_percentage(c.subcategory.goal, :precision => 2),
             number_to_percentage(c.var_perc, :precision => 2)
            ]            
            
    cogs_beginning_total << c.beginning
    cogs_purchase_total << c.purchase
    cogs_purchase_percentage_total << c.purchase_perc
    cogs_ending_total << c.ending
    cogs_cogs_total << c.cogs
    cogs_cogs_percentage_total << c.cogs_perc
    cogs_subcategory_goal_total << c.subcategory.goal
    cogs_var_percentage_total << c.var_perc          
end

rows << ['Food and Beverage Total',
          number_with_precision(cogs_beginning_total.inject(:+), :precision => 2),
          number_to_currency(cogs_purchase_total.inject(:+), :unit => peso_sign),
          number_to_percentage(cogs_purchase_percentage_total.inject(:+), :precision => 2),
          number_with_precision(cogs_ending_total.inject(:+), :precision => 2, :delimiter => 2),
          number_to_currency(cogs_cogs_total.inject(:+), :unit => peso_sign),
          number_to_percentage(cogs_cogs_percentage_total.inject(:+), :precision => 2),
          number_to_percentage(cogs_subcategory_goal_total.reject(&:nil?).inject(:+) || 0, :precision => 2),
          number_to_percentage(cogs_var_percentage_total.reject(&:nil?).inject(:+) || 0, :precision => 2)
        ]  
        
@directional.cogs2.each do |c2|
        
  rows << [c2.name,
            number_with_precision(c2.beginning, :precision => 2, :delimiter => ','),
            number_to_currency(c2.purchase, :unit => peso_sign),
            number_to_percentage(c2.purchase_perc, :precision => 2),
            number_with_precision(c2.ending, :precision => 2, :delimiter => ','),
            number_to_currency(c2.cogs, :unit => peso_sign),
            number_to_percentage(c2.cogs_perc, :precision => 2),
            number_to_percentage(c2.subcategory.goal, :precision => 2),
            number_to_percentage(c2.var_perc, :precision => 2)
          ]
            
        cogs_beginning_total2 << c2.beginning
        cogs_purchase_total2 << c2.purchase
        cogs_purchase_percentage_total2 << c2.purchase_perc
        cogs_ending_total2 << c2.ending
        cogs_cogs_total2 << c2.cogs
        cogs_cogs_percentage_total2 << c2.cogs_perc
        cogs_subcategory_goal_total2 << c2.subcategory.goal
        cogs_var_percentage_total2 << c2.var_perc          
end

rows << ['Alcohol Total',
          number_with_precision(cogs_beginning_total2.inject(:+), :precision => 2),
          number_to_currency(cogs_purchase_total2.inject(:+), :unit => peso_sign),
          number_to_percentage(cogs_purchase_percentage_total2.inject(:+), :precision => 2),
          number_with_precision(cogs_ending_total2.inject(:+), :precision => 2, :delimiter => 2),
          number_to_currency(cogs_cogs_total2.inject(:+), :unit => peso_sign),
          number_to_percentage(cogs_cogs_percentage_total2.inject(:+), :precision => 2),
          number_to_percentage(cogs_subcategory_goal_total2.reject(&:nil?).inject(:+) || 0, :precision => 2),
          number_to_percentage(cogs_var_percentage_total2.reject(&:nil?).inject(:+) || 0, :precision => 2)
        ]

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
