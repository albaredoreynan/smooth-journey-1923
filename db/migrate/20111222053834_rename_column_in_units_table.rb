class RenameColumnInUnitsTable < ActiveRecord::Migration
  def change
    rename_column :units, :name, :symbol
    rename_column :units, :description, :name
  end
    
end
