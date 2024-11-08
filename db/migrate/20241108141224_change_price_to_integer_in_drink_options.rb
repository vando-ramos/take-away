class ChangePriceToIntegerInDrinkOptions < ActiveRecord::Migration[7.1]
  def change
    change_column :drink_options, :price, :integer
  end
end
