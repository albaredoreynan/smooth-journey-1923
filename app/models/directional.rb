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
      ret[key] = rows.map(&:amount).inject(:+)
    end
    ret
  end

  def customer_count
    @sale.map(&:customer_count).inject(:+)
  end

  def per_person_ave
    @sale.map(&:per_person_ave).inject(:+)
  end

  def transaction_count
    @sale.map(&:transaction_count).inject(:+)
  end

  def per_trans_ave
    @sale.map(&:per_trans_ave).inject(:+).round(2)
  end

  def cogs
    cogs_category = Array.new
    subcategories = Subcategory.all
    subcategories.each do |s|
      cogs_category << CogsCategory.new(s, @ending_date, @branch)
    end
    cogs_category
  end
end
