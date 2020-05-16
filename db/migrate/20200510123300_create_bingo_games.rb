class CreateBingoGames < ActiveRecord::Migration[5.0]
  def change
    create_table :bingo_games do |t|
      t.text :numbers
      t.integer :index
      t.text :current_number

      t.timestamps
    end
  end
end
