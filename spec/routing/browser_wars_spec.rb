require 'rails_helper'

RSpec.describe "routing to browser_wars" do

  it "routes http://dyl.anjon.es/browserwars to browser_wars" do
    expect(get: "http://dyl.anjon.es/browserwars").to route_to(
      url: "browserwars",
      path: "browserwars",
      controller: "browser_wars",
      action: "index")
  end

end
