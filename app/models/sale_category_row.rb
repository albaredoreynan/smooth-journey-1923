class SaleCategoryRow < ActiveRecord::Base

  belongs_to :sale
  belongs_to :category,
    :class_name => 'SaleCategory',
    :foreign_key => :category_id
end
