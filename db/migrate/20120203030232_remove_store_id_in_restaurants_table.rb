class RemoveStoreIdInRestaurantsTable < ActiveRecord::Migration
  def up
    remove_column :restaurants, :store_id
  end
  
  def up
    add_column :restaurants, :store_id, :integer
  end
end
