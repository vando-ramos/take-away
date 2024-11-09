class RemoveUserIdFromOrders < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :user_id, :integer
  end
end
