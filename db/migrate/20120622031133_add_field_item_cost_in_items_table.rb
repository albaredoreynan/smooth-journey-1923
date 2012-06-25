class AddFieldItemCostInItemsTable < ActiveRecord::Migration
  def change
    add_column :items, :item_cost, :integer
  end
end
