class RenameColumnNumberInPhonecalls < ActiveRecord::Migration[4.2]
  def change
    rename_column :phonecalls, :number, :contact
  end
end
