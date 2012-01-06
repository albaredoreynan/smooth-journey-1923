class EndcountItem < Item
  attr_accessor :beginning_date, :ending_date

  def beginning_count
    last_count_from_previous_month
  end

  def beginning_total
    beginning_count * average_unit_cost if beginning_count
  end

  def ending_count
    counted_at(@ending_date).try(:stock_count)
  end

  def ending_total
    ending_count * average_unit_cost if ending_count
  end

  def cogs
    return if beginning_total.nil? or ending_total.nil? or purchase_amount_period.nil?
    beginning_total + purchase_amount_period - ending_total
  end

  def purchase_amount_period
    return if @beginning_date.nil? and @ending_date.nil?
    purchase_items.joins(:purchase)
      .where('purchases.purchase_date >= ?', @beginning_date)
      .where('purchases.purchase_date <= ?', @ending_date).map(&:net_amount).inject(:+)
  end

  def last_count_from_previous_month
    previous_month = @ending_date.to_date - 1.month
    sql = %Q{date_part('year', entry_date) = ? and date_part('month', entry_date) = ?}
    count = item_counts.where(sql, previous_month.year, previous_month.month).order('entry_date DESC').first
    count.try(:stock_count)
  end

  def average_unit_cost
    count = purchase_items.count.to_f
    return 0 if count == 0
    arr = []
    purchase_items.each do |pi|
      pi.convert_unit = true
      arr << pi.unit_cost
    end
    arr.inject(:+) / count
  end

end
