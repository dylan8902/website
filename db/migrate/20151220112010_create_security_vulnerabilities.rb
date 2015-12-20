class CreateSecurityVulnerabilities < ActiveRecord::Migration
  def change
    create_table :security_vulnerabilities do |t|
      t.string :domain
      t.string :url
      t.boolean :fixed
      t.text :summary
      t.text :description

      t.timestamps
    end
  end
end
