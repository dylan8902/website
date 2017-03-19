class AddWontFixToSecurityVulnerabilities < ActiveRecord::Migration[5.0]
  def change
    add_column :security_vulnerabilities, :wont_fix, :boolean, :default => false
  end
end
