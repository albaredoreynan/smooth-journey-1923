class AddUnitTypeToUnitsTable < ActiveRecord::Migration
  def change
    add_column :units, :unit_type, :string
  end
end
