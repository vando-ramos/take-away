class AddColumnsToPriceHistories < ActiveRecord::Migration[7.1]
  def change
    add_column :price_histories, :start_date, :datetime
    add_column :price_histories, :end_date, :datetime
  end
end
