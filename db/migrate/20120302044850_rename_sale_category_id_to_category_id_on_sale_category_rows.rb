class RenameSaleCategoryIdToCategoryIdOnSaleCategoryRows < ActiveRecord::Migration
  def up
    rename_column :sale_category_rows, :sale_category_id, :category_id
  end

  def down
    rename_column :sale_category_rows, :category_id, :sale_category_id
  end
end
