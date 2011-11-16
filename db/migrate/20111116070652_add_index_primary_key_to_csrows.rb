class AddIndexPrimaryKeyToCsrows < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE csrows ADD PRIMARY KEY (id)'
    execute 'ALTER TABLE csrows MODIFY COLUMN id INTEGER NOT NULL auto_increment'
    add_index :csrows, :sale_id
    add_index :csrows, :category_id
  end

  def down
    execute 'ALTER TABLE csrows MODIFY COLUMN id INTEGER NOT NULL'
    execute 'ALTER TABLE csrows DROP PRIMARY KEY'
    remove_index :csrows, :sale_id
    remove_index :csrows, :category_id
  end
end
