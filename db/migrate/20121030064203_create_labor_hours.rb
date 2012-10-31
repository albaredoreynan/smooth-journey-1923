class CreateLaborHours < ActiveRecord::Migration
  def change
    create_table :labor_hours do |t|
      t.date :working_date
      t.integer :branch_id
      t.string :regular
      t.string :overtime
      t.string :night_differential
      t.string :legal_holiday
      t.string :special_holiday
      t.string :absent
      t.string :late
      t.string :rest_day
      t.timestamps
    end
  end
end
