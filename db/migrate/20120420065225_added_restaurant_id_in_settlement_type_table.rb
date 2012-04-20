class AddedRestaurantIdInSettlementTypeTable < ActiveRecord::Migration
  def change
    add_column :settlement_types, :restaurant_id, :integer
  end
end
