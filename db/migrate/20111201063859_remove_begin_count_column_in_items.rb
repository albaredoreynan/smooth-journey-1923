class RemoveBeginCountColumnInItems < ActiveRecord::Migration
  def up
    remove_column :items, :begin_count
  end

  def down
    add_column :items, :begin_count, :double
  end
end
