class DropRolesAndCreateRoles < ActiveRecord::Migration
  def up
    drop_table :roles
    create_table :roles do |t|
      t.string :name
      t.references :user, :branch
      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
