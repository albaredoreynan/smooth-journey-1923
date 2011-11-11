class RenameSubcategoryFields < ActiveRecord::Migration
  def up
    rename_column :subcategories, :subcategory_name, :name
    rename_column :subcategories, :subcategory_description, :description
  end

  def down
    rename_column :subcategories, :name, :subcategory_name
    rename_column :subcategories, :description, :subcategory_description
  end
end
