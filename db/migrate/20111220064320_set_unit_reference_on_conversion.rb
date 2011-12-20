class SetUnitReferenceOnConversion < ActiveRecord::Migration
  def up
    remove_column :conversions, :b_unit
    remove_column :conversions, :s_unit
    execute 'ALTER TABLE conversions ADD COLUMN bigger_unit INTEGER REFERENCES units(id) ON UPDATE CASCADE ON DELETE CASCADE'
    execute 'ALTER TABLE conversions ADD COLUMN smaller_unit INTEGER REFERENCES units(id) ON UPDATE CASCADE ON DELETE CASCADE'
  end

  def down
    add_column :conversions, :b_unit, :text
    add_column :conversions, :s_unit, :text
    execute 'ALTER TABLE conversions DROP COLUMN bigger_unit'
    execute 'ALTER TABLE conversions DROP COLUMN smaller_unit'
  end
end
