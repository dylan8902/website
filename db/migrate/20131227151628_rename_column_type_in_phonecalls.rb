class RenameColumnTypeInPhonecalls < ActiveRecord::Migration[4.2]
  def change
    rename_column :phonecalls, :type, :category
  end
end
