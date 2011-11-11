class AddDescriptionColumnToUnits < ActiveRecord::Migration
  def change
    add_column :units, :description, :text
  end
end
