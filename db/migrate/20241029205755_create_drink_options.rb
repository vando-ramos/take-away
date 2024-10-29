class CreateDrinkOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :drink_options do |t|
      t.references :drink, null: false, foreign_key: true
      t.text :description
      t.string :price

      t.timestamps
    end
  end
end
