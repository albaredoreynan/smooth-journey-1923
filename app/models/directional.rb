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
  end

  def transaction_count
    @sale.map(&:transaction_count).reject{|t| t.nil? }.inject(:+)
  end

  def per_trans_ave
    @sale.map(&:per_trans_ave).reject{|p| p.nil?}.inject(:+).round(2) if @sale.length > 0
  end

  def cogs
    cogs_categories = Array.new
    subcategories = Subcategory.all
    subcategories.each do |s|
      cogs_category = CogsCategory.new(s, @ending_date, @branch)
      cogs_category.net_sale_total = net_sale_total
      cogs_categories << cogs_category
    end
    cogs_categories
  end

  def last_year
    last_year = 1.year.ago
    Directional.new(last_year.beginning_of_month, last_year.end_of_month, @branch)
  end
end
