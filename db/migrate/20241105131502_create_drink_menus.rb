class CreateDrinkMenus < ActiveRecord::Migration[7.1]
  def change
    create_table :drink_menus do |t|
      t.references :drink, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
