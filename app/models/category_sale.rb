class CategorySale < ActiveRecord::Base
  belongs_to :sale
  belongs_to :category

  validates_numericality_of :amount

  def self.category_sales_sum(date, category)
    joins('JOIN sales ON category_sales.sale_id = sales.id').where("date = ? and category_id = ?", date,category).map(&:amount).sum
  end

  def self.total_category_sales_sum(category)
    where("category_id = ?", category).map(&:amount).sum
  end

end
