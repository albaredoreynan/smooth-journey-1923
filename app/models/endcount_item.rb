class EndcountItem < Item
  attr_accessor :beginning_date, :ending_date
  attr_accessor :branch_id

  def beginning_count
    last_count_from_previous_month
  end

  def beginning_total
    beginning_count * unit_cost if beginning_count
  end

  def ending_count
    counted_at(@ending_date, @branch_id).try(:stock_count)
  end

  def ending_total
    ending_count * unit_cost if ending_count
  end

  def cogs
    return if beginning_total.nil? or ending_total.nil?
    beginning_total + purchase_amount_period.to_f - ending_total
  end
  
  def purchase_amount_period
    return if @beginning_date.nil? and @ending_date.nil?
    purchase_items.joins(:purchase)
      .where('purchases.branch_id = ?', @branch_id)
      .where('purchases.purchase_date >= ?', @beginning_date)
      .where('purchases.purchase_date <= ?', @ending_date).map(&:net_amount).inject(:+).to_f
  end
  
  def purchase_quantity
    return if @beginning_date.nil? and @ending_date.nil?
    purchase_items.joins(:purchase)
      .where('purchases.branch_id = ?', @branch_id)
      .where('purchases.purchase_date >= ?', @beginning_date)
      .where('purchases.purchase_date <= ?', @ending_date).map(&:quantity).inject(:+).to_f
  end
  
  def purchase_unit_cost
    return if purchase_quantity_true.nil? or purchase_amount_period.nil?
    p_amount = (purchase_amount_period / purchase_quantity_true)
    p_amount.round 2
  end  
  
  def ending_unit_cost
    return if beginning_total.nil? or beginning_count.nil?
    (beginning_total + purchase_amount_period.to_f) / (beginning_count + purchase_quantity_true.to_f)
  end
  
  def cogs_quantity
    return if beginning_count.nil? or ending_count.nil?
    (beginning_count + purchase_quantity_true.to_f) - ending_count.to_f 

  end
  
  def cogs_unit_cost
    return if cogs.nil? and cogs_quantity.nil?
    (cogs.to_f / cogs_quantity.to_f)  
  end  
  
  def unit_cost
    cost = purchased_items_last_month.length > 0 ?  average_unit_cost : last_unit_cost
    cost.round 2
  end
  
  def usage
    return if cogs.nil? 
    (cogs / unit_cost)
  end
  
  def purchase_quantity_true
    arr2 = []
    return 0 if @purchases.empty?
    @purchases.each do |pi|
      pi.convert_unit = true
      arr2 << pi.quantity
    end
    arr2.inject(:+)
  end
  
  private
  
  def last_count_from_previous_month
    previous_month = @ending_date.to_date - 1.month
    sql = %Q{date_part('year', entry_date) = ? and date_part('month', entry_date) = ? and branch_id = ?}
    count = item_counts.where(sql, previous_month.year, previous_month.month, @branch_id).order('entry_date DESC').first
    count.try(:stock_count)
  end

  def purchased_items_last_month
    period = @ending_date.nil? ? Date.today - 1.month : @ending_date - 1.month
    finder = purchase_items.joins(:purchase)
    finder = finder.start_date(period).end_date(period + 1.month)
    @purchases = finder
  end

  def average_unit_cost
    arr = []
    return 0 if @purchases.empty?
    @purchases.each do |pi|
      pi.convert_unit = true
      arr << pi.unit_cost
    end
    arr.inject(:+) / @purchases.length
  end
  
  def last_unit_cost
    last_purchased = purchase_items.joins(:purchase).order('purchases.purchase_date DESC').try(:first)
    last_purchased.try(:unit_cost) || 0
  end
end
