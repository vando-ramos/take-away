class DropTables < ActiveRecord::Migration[7.1]
  def change
    drop_table :order_dishes
    drop_table :order_drinks
    drop_table :dish_menus
    drop_table :drink_menus
    drop_table :drink_options
    drop_table :dish_options
    drop_table :drinks
    drop_table :dishes
  end
end
