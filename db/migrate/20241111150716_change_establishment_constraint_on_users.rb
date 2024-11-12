class ChangeEstablishmentConstraintOnUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :establishment_id, true
  end
end
