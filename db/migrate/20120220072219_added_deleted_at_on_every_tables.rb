class AddedDeletedAtOnEveryTables < ActiveRecord::Migration
  def initialize
    super
    @table_names = ActiveRecord::Base.connection.tables
  end
  
  def up
    @table_names.each do |t|
      add_column t.to_sym, :deleted_at, :datetime
    end
  end
  
  def down
    @table_names.each do |t|
      remove_column t.to_sym, :deleted_at
    end
  end
  
end
