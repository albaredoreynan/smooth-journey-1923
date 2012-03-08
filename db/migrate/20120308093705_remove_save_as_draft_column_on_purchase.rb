class RemoveSaveAsDraftColumnOnPurchase < ActiveRecord::Migration
  def up
    remove_column :purchases, :save_as_draft
  end

  def down
    add_column :purchases, :save_as_draft, :boolean
  end
end
