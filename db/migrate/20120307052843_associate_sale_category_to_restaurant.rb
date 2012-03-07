class AssociateSaleCategoryToRestaurant < ActiveRecord::Migration
  def up
    rename_column :sale_categories, :company_id, :restaurant_id
  end

  def down
    rename_column :sale_categories, :restaurant_id, :company_id
  end
end
