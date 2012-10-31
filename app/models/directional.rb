class Directional

  def initialize(beginning_date, ending_date, branch)
    @beginning_date = beginning_date
    @ending_date = ending_date
    @branch = branch

    @sale = Sale.start_date(@beginning_date).end_date(@ending_date).where(:branch_id => @branch)
    @sale_category_rows = SaleCategoryRow.where(:sale_id => @sale.map(&:id)).group_by do |scr|
      scr.category.name
    end
  end

  def net_sale_total
    total = 0
    net_sales.each do |key, val|
      total += val
    end
    total
  end

  def net_sales
    ret = Hash.new
    @sale_category_rows.each do |key, rows|
      ret[key] = rows.map(&:amount).reject{|a| a.nil?}.inject(:+)
    end
    ret
  end

  def customer_count
    @sale.map(&:customer_count).reject{|c| c.nil? }.inject(:+)
  end

  def per_person_ave
    @sale.map(&:per_person_ave).reject{|p| p.nil?}.inject(:+)
    return if net_sale_total.nil? or customer_count.nil?
    net_sale_total.to_f / customer_count.to_f
  end

  def transaction_count
    @sale.map(&:transaction_count).reject{|t| t.nil? }.inject(:+)
  end

  def per_trans_ave
    #@sale.map(&:per_trans_ave).reject{|p| p.nil?}.inject(:+).round(2) if @sale.length > 0
    return if net_sale_total.nil? or transaction_count.nil?
    net_sale_total.to_f / transaction_count.to_f
  end
  
  def delivery_transaction_count
    @sale.map(&:delivery_transaction_count).reject{|t| t.nil? }.inject(:+)
  end

  def per_del_trans_ave
    #@sale.map(&:per_trans_ave).reject{|p| p.nil?}.inject(:+).round(2) if @sale.length > 0
    return if net_sale_total.nil? or delivery_transaction_count.nil?
    net_sale_total.to_f / delivery_transaction_count.to_f
  end
  
  def cc_transaction_count
    @sale.map(&:credit_card_transaction_count).reject{|t| t.nil? }.inject(:+)
  end
  
  def dir_cash_in_drawer
    @sale.map(&:cash_in_drawer).reject{|t| t.nil? }.inject(:+)
  end
  
  def gc_sales
    @sale.map(&:gc_sales).reject{|t| t.nil? }.inject(:+)
  end
  
  def delivery_sales
    @sale.map(&:delivery_sales).reject{|t| t.nil? }.inject(:+)
  end
  
  def other_income
    @sale.map(&:other_income).reject{|t| t.nil? }.inject(:+)
  end

  def per_cc_trans_ave
    #@sale.map(&:per_trans_ave).reject{|p| p.nil?}.inject(:+).round(2) if @sale.length > 0
    return if net_sale_total.nil? or cc_transaction_count.nil?
    net_sale_total.to_f /  cc_transaction_count.to_f
  end
  
  def cogs
    cogs_categories = Array.new
    subcategories = Subcategory.find(:all, :conditions => { :non_inventory => false, :cogs_group => "Foods and Beverages"} )
    subcategories.each do |s|
      cogs_category = CogsCategory.new(s, @ending_date, @branch)
      cogs_category.net_sale_total = net_sale_total
      cogs_categories << cogs_category
    end
    cogs_categories
  end
  
  def cogs2
    cogs_categories2 = Array.new
    subcategories2 = Subcategory.find(:all, :conditions => { :non_inventory => false, :cogs_group => "Alcohol"} )
    subcategories2.each do |s|
      cogs_category2 = CogsCategory.new(s, @ending_date, @branch)
      cogs_category2.net_sale_total = net_sale_total
      cogs_categories2 << cogs_category2
    end
    cogs_categories2
  end

  def last_year
    last_year = 1.year.ago
    Directional.new(last_year.beginning_of_month, last_year.end_of_month, @branch)
  end
end
