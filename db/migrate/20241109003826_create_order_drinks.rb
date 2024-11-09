class CreateOrderDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :order_drinks do |t|
      t.references :order, null: false, foreign_key: true
      t.references :drink, null: false, foreign_key: true
      t.string :observation
      t.integer :quantity

      t.timestamps
    end
  end
end
