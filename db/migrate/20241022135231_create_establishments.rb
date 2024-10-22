class CreateEstablishments < ActiveRecord::Migration[7.1]
  def change
    create_table :establishments do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :cnpj
      t.string :address
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :email
      t.string :code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
