class AddStatusToDish < ActiveRecord::Migration[7.1]
  def change
    add_column :dishes, :status, :integer, default: 0
  end
end
