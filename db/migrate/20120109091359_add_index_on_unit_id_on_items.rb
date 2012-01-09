class AddIndexOnUnitIdOnItems < ActiveRecord::Migration
  def change
    add_index :items, :unit_id
  end
end
