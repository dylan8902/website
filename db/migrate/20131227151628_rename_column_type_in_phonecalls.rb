class RenameColumnTypeInPhonecalls < ActiveRecord::Migration
  def change
    rename_column :phonecalls, :type, :category
  end
end
