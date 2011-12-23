class RenameNameDataTypesInUnitsTable < ActiveRecord::Migration
  def up
    change_column :units, :name, :string  
  end

  def down
    change_column :units, :name, :text
  end
end
