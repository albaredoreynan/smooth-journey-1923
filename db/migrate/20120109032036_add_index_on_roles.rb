class AddIndexOnRoles < ActiveRecord::Migration
  def change
    add_index :roles, :user_id
    add_index :roles, :branch_id
  end
end
