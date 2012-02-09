class DropEndcounts < ActiveRecord::Migration
  def change
    drop_table :endcounts
  end
end
