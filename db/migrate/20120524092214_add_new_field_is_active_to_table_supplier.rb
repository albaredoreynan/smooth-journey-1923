class AddNewFieldIsActiveToTableSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :is_active, :boolean, :default => true
  end
end
