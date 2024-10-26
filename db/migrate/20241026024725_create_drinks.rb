class CreateDrinks < ActiveRecord::Migration[7.1]
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :description
      t.integer :calories
      t.string :image
      t.integer :is_alcoholic
      t.references :establishment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
