class AddedNewFieldsCogsGroupInTableSubcategories < ActiveRecord::Migration
  def change
    add_column :subcategories, :cogs_group, :string
  end
end
