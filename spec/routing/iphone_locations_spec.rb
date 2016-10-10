require 'rails_helper'

RSpec.describe "routing to iphone_locations" do

  it "routes http://dyl.anjon.es/iphone to iphone_locations" do
    expect(get: "http://dyl.anjon.es/iphone").to route_to(
      url: "iphone",
      path: "iphone",
      controller: "iphone_locations",
      action: "index")
  end

end
