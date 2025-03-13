class AddTypeToOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :options, :type, :string
  end
end
