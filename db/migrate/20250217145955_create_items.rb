class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :calories
      t.string :image
      t.references :establishment, null: false, foreign_key: true
      t.integer :is_alcoholic
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
