class DropDishTags < ActiveRecord::Migration[7.1]
  def change
    drop_table :dish_tags
  end
end
