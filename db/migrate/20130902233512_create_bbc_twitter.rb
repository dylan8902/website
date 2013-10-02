class CreateBbcTwitter < ActiveRecord::Migration
  def up
    create_table :bbc_twitter, :force => true do |table|
      table.string   :title
      table.string   :link
      table.integer  :count

      table.timestamps
    end
  end
end
