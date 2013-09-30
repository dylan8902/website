class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.string :url, :null => false
      t.integer :hits, :default => 0
      t.boolean :online

      t.timestamps
    end
  end
end
