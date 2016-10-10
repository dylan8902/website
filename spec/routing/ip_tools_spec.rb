require 'rails_helper'

RSpec.describe "routing to ip_tools" do

  it "routes http://dyl.anjon.es/ip-tools to ip_tools" do
    expect(get: "http://dyl.anjon.es/ip-tools").to route_to(
      url: "ip-tools",
      path: "ip-tools",
      controller: "ip_tools",
      action: "index")
  end

end
