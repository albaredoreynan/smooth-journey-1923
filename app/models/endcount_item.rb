class EndcountItem < Item
  attr_accessor :beginning_count, :ending_count
  attr_accessor :beginning_total, :ending_total
  attr_accessor :purchase
  attr_accessor :cogs

  def purchase_amount_period(date_from, date_to)
    purchase_items.joins(:purchase)
      .where('purchases.purchase_date >= ?', date_from.to_date)
      .where('purchases.purchase_date <= ?', date_to.to_date).map(&:net_amount).inject(:+)
  end

  def last_count_from_previous_month(date)
    previous_month = date.to_date - 1.month
    sql = %Q{date_part('year', entry_date) = ? and date_part('month', entry_date) = ?}
    count = item_counts.where(sql, previous_month.year, previous_month.month).order('entry_date ASC').first
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
