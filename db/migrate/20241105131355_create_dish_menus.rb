class CreateDishMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :dish_menus do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
