class CreatePriceHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :price_histories do |t|
      t.string :price
      t.integer :item_type
      t.integer :item_id

      t.timestamps
    end

    add_index :price_histories, [:item_type, :item_id]
  end
end
