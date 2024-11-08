class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :establishment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :customer_name
      t.string :customer_cpf
      t.string :customer_email
      t.string :customer_phone
      t.integer :total_value
      t.string :code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
