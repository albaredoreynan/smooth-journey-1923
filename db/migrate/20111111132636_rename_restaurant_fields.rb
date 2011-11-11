class RenameRestaurantFields < ActiveRecord::Migration
  def up
    rename_column :restaurants, :restaurant_name, :name
    rename_column :restaurants, :restaurant_description, :description
  end

  def down
    rename_column :restaurants, :name, :restaurant_name
    rename_column :restaurants, :description, :restaurant_description
  end
end
