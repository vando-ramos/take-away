class CreateDishOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :dish_options do |t|
      t.references :dish, null: false, foreign_key: true
      t.text :description
      t.string :price

      t.timestamps
    end
  end
end
