class AddIndexToSettings < ActiveRecord::Migration
  def change
    add_index :settings, :company_id
  end
end
