class CreateTrainOperatingCompanies < ActiveRecord::Migration[4.2]
  def change
    create_table :train_operating_companies do |t|
      t.string :name
      t.string :business_code
      t.integer :numeric_code
      t.string :atoc
    end
    add_index :train_operating_companies, :atoc
  end
end
