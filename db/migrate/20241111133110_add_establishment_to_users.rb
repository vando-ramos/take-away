class AddEstablishmentToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :establishment, null: false, foreign_key: true
  end
end
