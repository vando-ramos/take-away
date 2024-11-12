class RenameIdentificationNumberToCpfInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :identification_number, :cpf
  end
end
