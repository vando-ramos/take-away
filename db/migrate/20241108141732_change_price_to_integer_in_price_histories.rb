class ChangePriceToIntegerInPriceHistories < ActiveRecord::Migration[7.1]
  def change
    change_column :price_histories, :price, :integer
  end
end
