class DropRestaurantcategories < ActiveRecord::Migration
  def change
    drop_table :restaurantcategories
  end
end
