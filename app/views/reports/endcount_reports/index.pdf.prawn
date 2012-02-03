pdf.text 'Endcount Report', :style => :bold
pdf.text "Date: #{@ending_date.strftime("%-d-%b-%Y")}"
pdf.move_down 10
pdf.font_size 7

rows = []
headers = ['Item', 'Unit cost', 'Unit', 'Beginning count', 'Beginning total',
  'Purchases', 'Ending count', 'Ending total', 'COGS']
rows << headers

@endcount
grand_total_beginning_count = 0.0
grand_total_beginning_total = 0.0
grand_total_purchase_amount = 0.0
grand_total_ending_count = 0.0
grand_total_ending_total = 0.0
grand_total_cogs = 0.0
by_subcategory = @endcount.items.group_by { |i| i.subcategory }
by_subcategory.each do |subcategory, items|
  subtotal_beginning_count = items.map(&:beginning_count).reject(&:nil?).inject(:+)
  grand_total_beginning_count += subtotal_beginning_count if subtotal_beginning_count
  subtotal_beginning_count
  subtotal_beginning_total = items.map(&:beginning_total).reject(&:nil?).inject(:+)
  grand_total_beginning_total += subtotal_beginning_total if subtotal_beginning_total
  number_to_currency(subtotal_beginning_total, :unit => peso_sign)
  subtotal_purchase_amount = items.map(&:purchase_amount_period).reject(&:nil?).inject(:+)
  grand_total_purchase_amount += subtotal_purchase_amount if subtotal_purchase_amount
  number_to_currency(subtotal_purchase_amount, :unit => peso_sign)
  subtotal_ending_count = items.map(&:ending_count).reject(&:nil?).inject(:+)
  grand_total_ending_count += subtotal_ending_count if subtotal_ending_count
  subtotal_ending_count
  subtotal_ending_total = items.map(&:ending_total).reject(&:nil?).inject(:+)
  grand_total_ending_total += subtotal_ending_total if subtotal_ending_total
  number_to_currency(subtotal_ending_total, :unit => peso_sign)
  subtotal_cogs = items.map(&:cogs).reject(&:nil?).inject(:+)
  grand_total_cogs += subtotal_cogs if subtotal_cogs
  number_with_precision(subtotal_cogs, :precision => 2, :delimiter => ',')
  rows << [subcategory.name, nil, nil,
    subtotal_beginning_count,
    number_to_currency(subtotal_beginning_total, :unit => peso_sign),
    number_to_currency(subtotal_purchase_amount, :unit => peso_sign),
    subtotal_ending_count,
    number_to_currency(subtotal_ending_total, :unit => peso_sign),
    subtotal_cogs]
  items.each do |item|
    rows << [item.name, number_to_currency(item.unit_cost, :unit => peso_sign),
      item.unit_name, item.beginning_count,
      number_to_currency(item.beginning_total, :unit => peso_sign),
      number_to_currency(item.purchase_amount_period, :unit => peso_sign),
      item.ending_count,
      number_to_currency(item.ending_total, :unit => peso_sign),
      number_to_currency(item.cogs, :unit => peso_sign)]
  end
  rows << ['Total', nil, nil,
    grand_total_beginning_count,
    number_to_currency(grand_total_beginning_total, :unit => peso_sign),
    number_to_currency(grand_total_purchase_amount, :unit => peso_sign),
    grand_total_ending_count,
    number_to_currency(grand_total_ending_total, :unit => peso_sign),
    grand_total_cogs]
end

pdf.table ( rows ) do
  header = true
  columns(4).align = :right
  columns(6..9).align = :right
end