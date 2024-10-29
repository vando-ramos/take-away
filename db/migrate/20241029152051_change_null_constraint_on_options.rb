class ChangeNullConstraintOnOptions < ActiveRecord::Migration[7.1]
  def change
    change_column_null :options, :dish_id, true
    change_column_null :options, :drink_id, true
  end
end
