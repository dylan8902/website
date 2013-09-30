class CreateTextMessages < ActiveRecord::Migration
  def change
    create_table :text_messages do |t|
      t.string :contact, :null => false
      t.text :text
      t.boolean :sent
      
      t.timestamps
    end
  end
end
