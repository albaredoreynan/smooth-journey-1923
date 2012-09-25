pdf.start_new_page :layout => :landscape
pdf.font_size 7
pdf.text "Item Cost Analysis as of #{@ending_date.strftime("%-d-%b-%Y")}" , :style => :bold
@branch_sel = Branch.find(params[:branch_id]) if params[:branch_id]
pdf.text "Branch : #{@branch_sel.location if @branch_sel}" , :style => :bold
pdf.text "Reference : BI = Beginning Inventory / TP = Total Purchases / EI = Ending Inventory / COGS = Cost Of Goods Sold" , :style => :bold

pdf.move_down 10
pdf.font_size 7

rows = []

headers = [
           'Item', 'Unit', 
           'BI Qty', 'BI Unit Cost', 'BI Total',
           'TP Qty', 'TP Unit Cost', 'TP Amount',
           'EI Qty', 'EI Unit Cost', 'EI Amount',
           'COGS Qty', 'COGS Unit Cost', 'COGS Amount', '%'
          ]
rows << headers


  grand_total_beginning_total = 0.0
  grand_total_purchase_amount = 0.0
  grand_total_ending_total = 0.0
  grand_total_cogs = 0.0  
  
  by_subcategory = @endcount.items.group_by { |i| i.subcategory }
  by_subcategory.each do |subcategory, items|
    
    subtotal_beginning_total = items.map(&:beginning_total).reject(&:nil?).inject(:+)
    grand_total_beginning_total += subtotal_beginning_total if subtotal_beginning_total
    
    subtotal_purchase_amount = items.map(&:purchase_amount_period).reject(&:nil?).inject(:+)
    grand_total_purchase_amount += subtotal_purchase_amount if subtotal_purchase_amount
    
    subtotal_ending_total = items.map(&:ending_total).reject(&:nil?).inject(:+)
    grand_total_ending_total += subtotal_ending_total if subtotal_ending_total

    subtotal_cogs = items.map(&:cogs).reject(&:nil?).inject(:+)
    grand_total_cogs += subtotal_cogs if subtotal_cogs    
    
    rows << [
              subcategory.name.upcase, '',
              '', '', number_to_currency(subtotal_beginning_total, :unit => peso_sign),
              '', '', number_to_currency(subtotal_purchase_amount, :unit => peso_sign),
              '', '', number_to_currency(subtotal_ending_total, :unit => peso_sign),
              '', '', number_to_currency(subtotal_cogs, :unit => peso_sign),
              ''
            ]
      
    items.each do |item|
      @units = Unit.find(item.unit_id)
      item.purchase_unit_cost.nan? ? p_unit_cost = 0.0 : p_unit_cost = item.purchase_unit_cost
      item.ending_unit_cost.nan? ? e_unit_cost = 0.0 : e_unit_cost = item.ending_unit_cost   
      rows << [   
                item.name, @units.name, 
                number_with_precision(item.beginning_count, :precision => 2, :delimiter => ','),
                number_to_currency(item.unit_cost, :unit => peso_sign),
                number_to_currency(item.beginning_total, :unit => peso_sign),
                
                number_with_precision(item.purchase_quantity_true, :precision => 2, :delimiter => ','),
                
                number_to_currency(p_unit_cost, :unit => peso_sign),
                number_to_currency(item.purchase_amount_period, :unit => peso_sign),
                  
                number_with_precision(item.ending_count, :precision => 2, :delimiter => ','),
                number_to_currency(e_unit_cost, :unit => peso_sign),
                number_to_currency(item.ending_total, :unit => peso_sign),
                  
                number_with_precision(item.cogs_quantity, :precision => 2, :delimiter => ','),
                number_to_currency(item.cogs_unit_cost, :unit => peso_sign),
                number_to_currency(item.cogs, :unit => peso_sign),
                ''
              ]
    end
               
  end
  rows << [
           'Grand Total', '',
           '', '', number_to_currency(grand_total_beginning_total, :unit => peso_sign),
           '', '', number_to_currency(grand_total_purchase_amount, :unit => peso_sign),
           '', '', number_to_currency(grand_total_ending_total, :unit => peso_sign),
           '', '', number_to_currency(grand_total_cogs, :unit => peso_sign),
           ''
          ]
    
pdf.table rows,
  :border_style => :grid,
  :font_size => 6,
  :position => :center,
  :row_colors => ["d2e3ed", "FFFFFF"]

pdf.font_size 6
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
  pagecount = pdf.page_count
  pdf.text "Page #{pagecount}"
end
