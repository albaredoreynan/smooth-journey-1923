pdf.start_new_page :layout => :landscape
pdf.text "Directional as of #{@ending_date.strftime("%-d-%b-%Y")}" , :style => :bold
pdf.move_down 10
pdf.font_size 7

rows3 = []
headers3 = ['NET SALES(Category)', 'Amount', 'Percentage']
rows3 << headers3  
      
directional_categories_percentage = Array.new
last_year = @directional.last_year

@directional.net_sales.each do |category, net_sale|
amount_percentage = net_sale.to_f.percent_of(@directional.net_sale_total)
directional_categories_percentage << amount_percentage
rows3 << [category, number_to_currency(net_sale, :unit => peso_sign), number_to_percentage(amount_percentage)]
end

rows3 << ['Total', @directional.net_sale_total, number_to_percentage(directional_categories_percentage.inject(:+))]

pdf.table rows3,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]
pdf.move_down 10

rows2 = []
headers2 = ['NET SALES', 'MTD', 'LAST YEAR']
rows2 << headers2
rows2 << ['Total', number_to_currency(@directional.net_sale_total, :unit => peso_sign), number_to_currency(last_year.net_sale_total, :unit => peso_sign)]
rows2 << ['Customer Count', number_with_precision(@directional.customer_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.customer_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Person Ave', number_with_precision(@directional.per_person_ave, :precision => 2, :delimiter => ','), number_with_precision(last_year.per_person_ave, :precision => 2, :delimiter => ',')]
rows2 << ['Transaction Count', number_with_precision(@directional.transaction_count, :precision => 2, :delimiter => ','), number_with_precision(last_year.transaction_count, :precision => 2, :delimiter => ',')]
rows2 << ['Per Transaction Ave', number_with_precision(@directional.per_trans_ave, :precision => 2, :delimiter => ','), number_with_precision(last_year.per_trans_ave, :precision => 2, :delimiter => ',')]

pdf.table rows2,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"]

pdf.move_down 10
  
rows = []
headers = ['Cost of Goods', 'Beggining', 'Purchase', 'Purchase %', 'Ending', 'COGS', 'COGS %', 'Goal %', 'VAR +/-']

rows << headers

@directional.cogs.each do |c|
rows << [c.name, 
	number_with_precision(c.beginning, :precision => 2, :delimiter => ','),
	number_to_currency(c.purchase, :unit => peso_sign),
	number_to_percentage(c.purchase_perc),
	number_with_precision(c.ending, :precision => 2, :delimiter => ','),
	number_with_precision(c.cogs, :precision => 2, :delimiter => ','),
	number_to_percentage(c.cogs_perc),
	number_to_percentage(c.subcategory.goal),
	number_to_percentage(c.var_perc)
	]
end

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