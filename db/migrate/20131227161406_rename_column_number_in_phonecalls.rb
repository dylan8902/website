class RenameColumnNumberInPhonecalls < ActiveRecord::Migration
  def change
    rename_column :phonecalls, :number, :contact
  end
end
