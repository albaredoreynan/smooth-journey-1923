class CreateAmountMultipliers < ActiveRecord::Migration
  def change
    create_table :amount_multipliers do |t|
      t.string :amount_per_hour_regular
      t.string :amount_per_hour_overtime
      t.string :amount_per_hour_night_differential
      t.string :amount_per_hour_legal_holiday
      t.string :amount_per_hour_special_holiday
      t.string :amount_per_hour_absent
      t.string :amount_per_hour_late
      t.string :amount_per_hour_rest_day
      t.timestamps
    end
  end
end
