class CogsCategory

  def initialize(subcategory, ending_date, branch_id)
    @subcategory    = subcategory
    @ending_date    = ending_date
    @beginning_date = ending_date.beginning_of_month - 1.day
    @branch_id      = branch_id
  end

  def beginning
    counts_at(@beginning_date)
  end

  def ending
    counts_at(@ending_date)
  end

  def purchase
    purchase_items = PurchaseItem.joins(:purchase, [:item => :subcategory]).
      where('purchases.branch_id = ?', @branch_id).
      where('purchases.purchase_date >= ? AND purchases.purchase_date <= ?', @beginning_date, @ending_date).
      where('subcategories.id = ?', @subcategory.id)
    purchase_items.map(&:amount).inject(:+)
  end

  def counts_at(date)
    item_counts = ItemCount.joins(:item => :subcategory).
      where(:branch_id => @branch_id, :entry_date => date).
      where('subcategories.id = ?', @subcategory.id)
    item_counts.map(&:stock_count).inject(:+)
  end

  def cogs
    beginning + purchase - ending
  end
end
