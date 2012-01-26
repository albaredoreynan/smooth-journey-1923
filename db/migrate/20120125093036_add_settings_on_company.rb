class AddSettingsOnCompany < ActiveRecord::Migration
  def up
    add_column :companies, :settings, :text
  end

  def down
    remove_column :companies, :settings
  end
end
