require 'rails_helper'

RSpec.describe "routing to locations" do

  it "routes http://dyl.anjon.es/location to locations" do
    expect(get: "http://dyl.anjon.es/location").to route_to(
      controller: "locations",
      action: "index")
  end

end
