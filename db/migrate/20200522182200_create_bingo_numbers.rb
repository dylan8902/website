class CreateBingoNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :bingo_numbers do |t|
      t.text :instruction
      t.text :song_name
      t.text :song_url

      t.timestamps
    end
  end
end
