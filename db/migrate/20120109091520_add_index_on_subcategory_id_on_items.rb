class AddIndexOnSubcategoryIdOnItems < ActiveRecord::Migration
  def change
    add_index :items, :subcategory_id
  end

end
