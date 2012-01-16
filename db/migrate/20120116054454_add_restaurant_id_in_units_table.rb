class AddRestaurantIdInUnitsTable < ActiveRecord::Migration
  def change
    add_column :units, :restaurant_id, :integer
    add_index :units, :restaurant_id
  end
end
