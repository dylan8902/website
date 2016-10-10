require 'rails_helper'

RSpec.describe "routing to security_vulnerabilities" do

  it "routes http://dyl.anjon.es/security-vulnerabilities to security_vulnerabilities" do
    expect(get: "http://dyl.anjon.es/security-vulnerabilities").to route_to(
      url: "security-vulnerabilities",
      path: "security-vulnerabilities",
      controller: "security_vulnerabilities",
      action: "index")
  end

end
