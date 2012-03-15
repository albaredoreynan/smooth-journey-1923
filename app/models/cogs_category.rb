class CogsCategory

  attr_accessor :net_sale_total
  attr_accessor :subcategory

  def initialize(subcategory, ending_date, branch)
    @subcategory    = subcategory
    @ending_date    = ending_date
    @beginning_date = ending_date.beginning_of_month - 1.day
    @branch         = branch
  end

  def name
    @subcategory.name
  end

  def beginning
    counts_at(@beginning_date)
  end

  def ending
    counts_at(@ending_date)
  end

  def purchase
    purchase_items = PurchaseItem.joins(:purchase, [:item => :subcategory]).
      where('purchases.branch_id = ?', @branch.id).
      where('purchases.purchase_date >= ? AND purchases.purchase_date <= ?', @beginning_date, @ending_date).
      where('subcategories.id = ?', @subcategory.id)
    purchase_items.map(&:amount).inject(:+) || 0
  end

  def counts_at(date)
    item_counts = ItemCount.joins(:item => :subcategory).
      where(:branch_id => @branch.id, :entry_date => date).
      where('subcategories.id = ?', @subcategory.id)
    item_counts.map(&:stock_count).inject(:+) || 0
  end

  def cogs
    beginning + purchase - ending
  end

  def purchase_perc
    unless net_sale_total == 0 or net_sale_total.nil?
      ((purchase / net_sale_total) * 100).round(2)
    end
  end

  def cogs_perc
    unless net_sale_total == 0 or net_sale_total.nil?
      ((cogs / net_sale_total) * 100).round(2)
    end
  end

  def var_perc
    unless @subcategory.goal.nil? or cogs_perc.nil?
      @subcategory.goal - cogs_perc
    end
  end
end
