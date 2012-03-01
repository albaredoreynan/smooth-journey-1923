class CreateSaleCategoryTable < ActiveRecord::Migration
  def up
    create_table :sale_categories do |t|
      t.integer :company_id
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :sale_categories, :company_id
  end

  def down
    drop_table :sale_categories
  end
end
