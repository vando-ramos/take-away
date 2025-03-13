class AddOptionToPriceHistories < ActiveRecord::Migration[7.1]
  def change
    add_reference :price_histories, :option, null: false, foreign_key: true
  end
end
