class RemoveDateColumnInServer < ActiveRecord::Migration
  def up
    remove_column :servers, :date
  end

  def down
    add_column :servers, :date, :datetime
  end
end
