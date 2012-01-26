class AddCreatedByOnPurchases < ActiveRecord::Migration
  def up
    add_column :purchases, :created_by_id, :integer
    add_index :purchases, :created_by_id
  end

  def down
    remove_index :purchases, :created_by_id
    remove_column :purchases, :created_by_id
  end
end
