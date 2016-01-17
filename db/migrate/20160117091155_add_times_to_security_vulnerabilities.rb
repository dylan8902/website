class AddTimesToSecurityVulnerabilities < ActiveRecord::Migration
  def change
    add_column :security_vulnerabilities, :reported_at, :timestamp
    add_column :security_vulnerabilities, :fixed_at, :timestamp
  end
end
