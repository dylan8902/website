require 'rails_helper'

RSpec.describe "routing to browser_wars" do

  it "routes http://dyl.anjon.es/browserwars to browser_wars" do
    expect(get: "http://dyl.anjon.es/browserwars").to route_to(
      controller: "browser_wars",
      action: "index")
  end

end
