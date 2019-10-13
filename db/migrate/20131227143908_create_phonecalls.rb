class CreatePhonecalls < ActiveRecord::Migration[4.2]
  def change
    create_table :phonecalls do |t|
      t.string :date
      t.string :time
      t.string :number
      t.string :type
      t.string :duration
      t.string :price
      t.string :included

      t.timestamps
    end
    add_index :phonecalls, :number
  end
end
