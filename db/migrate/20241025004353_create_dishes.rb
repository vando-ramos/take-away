class CreateDishes < ActiveRecord::Migration[7.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :description
      t.integer :calories
      t.string :image
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
