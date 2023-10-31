class CreateDuoParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :duo_participants do |t|
      t.string :name
      t.string :photo

      t.timestamps
    end
  end
end
