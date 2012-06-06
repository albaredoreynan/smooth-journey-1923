class AddFieldNonInventoryOnSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :non_inventory, :boolean, :default => false
  end
end
