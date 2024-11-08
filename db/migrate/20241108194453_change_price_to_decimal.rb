class ChangePriceToDecimal < ActiveRecord::Migration[7.1]
  def change
    change_column :dish_options, :price, :decimal, precision: 8, scale: 2
    change_column :drink_options, :price, :decimal, precision: 8, scale: 2
    change_column :price_histories, :price, :decimal, precision: 8, scale: 2
    change_column :orders, :total_value, :decimal, precision: 8, scale: 2
  end
end
