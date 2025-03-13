class AddTypeToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :type, :string
  end
end
