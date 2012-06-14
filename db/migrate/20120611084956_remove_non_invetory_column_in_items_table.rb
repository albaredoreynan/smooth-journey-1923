class RemoveNonInvetoryColumnInItemsTable < ActiveRecord::Migration
  def up
    remove_column :items, :non_inventory
    add_column :items, :item_group, :string
  end

  def down
    add_column :items, :non_inventory, :boolean
    remove_column :items, :item_group
  end
end
