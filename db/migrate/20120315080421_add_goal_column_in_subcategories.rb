class AddGoalColumnInSubcategories < ActiveRecord::Migration
  def up
    add_column :subcategories, :goal, :float
  end

  def down
    remove_column :subcategories, :goal
  end
end
