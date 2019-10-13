class AddTimesToSecurityVulnerabilities < ActiveRecord::Migration[4.2]
  def change
    add_column :security_vulnerabilities, :reported_at, :timestamp
    add_column :security_vulnerabilities, :fixed_at, :timestamp
  end
end
