class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :currency
      t.string :symbol

      t.timestamps
    end
  end
end
