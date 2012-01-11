class RemoveRestaurantCategoryIdInCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :restaurant_category_id
  end
end
