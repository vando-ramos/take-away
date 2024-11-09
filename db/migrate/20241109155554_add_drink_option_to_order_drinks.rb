class AddDrinkOptionToOrderDrinks < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_drinks, :drink_option, null: false, foreign_key: true
  end
end
