class UpdateOptionsForPolymorphicAssociation < ActiveRecord::Migration[7.1]
  def change
    remove_column :options, :item_id, :integer
    remove_column :options, :type, :string

    add_column :options, :optionable_id, :integer, null: false
    add_column :options, :optionable_type, :string, null: false

    add_index :options, [:optionable_id, :optionable_type], name: "index_options_on_optionable"
  end
end
