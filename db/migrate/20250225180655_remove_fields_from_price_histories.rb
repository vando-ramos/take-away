class RemoveFieldsFromPriceHistories < ActiveRecord::Migration[7.1]
  def change
    remove_column :price_histories, :item_type, :integer
    remove_column :price_histories, :item_id, :integer
  end
end
