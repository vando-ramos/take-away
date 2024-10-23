class CreateOperatingHours < ActiveRecord::Migration[7.1]
  def change
    create_table :operating_hours do |t|
      t.integer :day_of_week
      t.time :opening_time
      t.time :closing_time
      t.integer :status, default: 0
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
