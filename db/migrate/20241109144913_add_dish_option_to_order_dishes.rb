class AddDishOptionToOrderDishes < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_dishes, :dish_option, null: false, foreign_key: true
  end
end
