class AddColumnIsActiveInTableSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :is_active, :boolean, :default => true
  end
end
