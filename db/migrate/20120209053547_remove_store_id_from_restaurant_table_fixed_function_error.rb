class RemoveStoreIdFromRestaurantTableFixedFunctionError < ActiveRecord::Migration
  def up
    remove_column :restaurants, :store_id
  end
  
  def down
    add_column :restaurants, :store_id, :integer
  end
end
