class ChangeBranchIdToIntegerOnItems < ActiveRecord::Migration
  def up
    remove_column :items, :branch_id
    change_table :items do |t|
      t.references :branch
    end
  end

  def down
    remove_column :items, :branch_id
    add_column :items, :branch_id, :string
  end
end
