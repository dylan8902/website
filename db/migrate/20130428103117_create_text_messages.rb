class CreateTextMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :text_messages do |t|
      t.string :contact, :null => false
      t.text :text
      t.boolean :sent

      t.timestamps
    end
  end
end
