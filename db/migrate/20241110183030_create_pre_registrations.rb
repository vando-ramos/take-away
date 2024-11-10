class CreatePreRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :pre_registrations do |t|
      t.references :establishment, null: false, foreign_key: true
      t.string :email
      t.string :cpf
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
