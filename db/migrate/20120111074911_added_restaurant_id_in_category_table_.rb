class AddedRestaurantIdInCategoryTable_ < ActiveRecord::Migration
  def change
    add_column :categories, :restaurant_id, :integer
    add_index :categories, :restaurant_id
  end
end
