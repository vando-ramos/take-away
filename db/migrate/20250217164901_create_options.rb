class CreateOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :options do |t|
      t.references :item, null: false, foreign_key: true
      t.string :description
      t.decimal :price

      t.timestamps
    end
  end
end
