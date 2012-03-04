class AddRestaurantIdOnItem < ActiveRecord::Migration
  def up
    add_column :items, :restaurant_id, :integer
    add_index :items, :restaurant_id

    Item.all.each do |item|
      item.restaurant = item.branch.restaurant
      item.save
    end
  end

  def down
    remove_column :items, :restaurant_id
  end
end
