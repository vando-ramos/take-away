class ChangePriceToIntegerInDishOptions < ActiveRecord::Migration[7.1]
  def change
    change_column :dish_options, :price, :integer
  end
end
