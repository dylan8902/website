class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :pid, :null => false
      t.string :title, :null => false
      t.string :description, :null => false

      t.timestamps
    end
  end
end
