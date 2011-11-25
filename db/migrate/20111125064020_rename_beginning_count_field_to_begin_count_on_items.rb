class RenameBeginningCountFieldToBeginCountOnItems < ActiveRecord::Migration
  def up
     rename_column :items, :beginning_count, :begin_count
  end

  def down
    rename_column :items, :begin_count, :beginning_count
  end
end
