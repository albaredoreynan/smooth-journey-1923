class RenameUnitFields < ActiveRecord::Migration
  def up
    rename_column :units, :unit_name, :name
  end

  def down
    rename_column :units, :name, :unit_name
  end
end
