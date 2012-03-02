class AddSaleCategoryRowsTable < ActiveRecord::Migration
  def up
    create_table :sale_category_rows do |t|
      t.integer :sale_category_id
      t.integer :sale_id
      t.decimal :amount

      t.timestamp
      t.datetime :deleted_at
    end

    add_index :sale_category_rows, :sale_category_id
    add_index :sale_category_rows, :sale_id
  end

  def down
    drop_table :sale_category_rows
  end
end
