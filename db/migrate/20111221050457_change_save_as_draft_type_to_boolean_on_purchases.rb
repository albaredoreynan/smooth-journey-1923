class ChangeSaveAsDraftTypeToBooleanOnPurchases < ActiveRecord::Migration
  def up
    remove_column :purchases, :save_as_draft
    add_column :purchases, :save_as_draft, :boolean
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
