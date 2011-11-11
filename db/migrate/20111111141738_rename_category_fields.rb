class RenameCategoryFields < ActiveRecord::Migration
  def up
    rename_column :categories, :category_name, :name
    rename_column :categories, :category_description, :description
  end

  def down
    rename_column :categories, :name, :category_name
    rename_column :categories, :description, :category_description
  end
end
