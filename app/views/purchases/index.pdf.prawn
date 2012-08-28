pdf.start_new_page
pdf.text "Purchase Lists From: #{params[:start_date]} To #{params[:end_date]} " , :style => :bold

pdf.move_down 10
pdf.font_size 7

row1 = []
          
row1 << ["Invoice Number", "Purchase Date", "Supplier Name", "Purchase Amount", "Net Amount", "Vat Amount"]
    @purchases.each do |purchase|
      pdate = purchase.purchase_date.strftime("%-d-%b-%Y") if purchase.purchase_date
      row1 << [ purchase.invoice_number, pdate, purchase.supplier.name, number_to_currency(purchase.amount, :unit => peso_sign), number_to_currency(purchase.net_amount, :unit => peso_sign), number_to_currency(purchase.vat_amount, :unit => peso_sign) ]
    end

pdf.move_down 10

pdf.table row1,
  :border_style => :grid,
  :font_size => 8,
  :position => :left,
  :row_colors => ["d2e3ed", "FFFFFF"],
  :column_widths => { 0 => 70, 1 => 70, 2 => 100, 3 => 100, 4 => 100, 5 => 100}
