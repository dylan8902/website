require 'rails_helper'

RSpec.describe "routing to realtime" do

  it "routes http://dyl.anjon.es/realtime to realtime" do
    expect(get: "http://dyl.anjon.es/realtime").to route_to(
      url: "realtime",
      path: "realtime",
      controller: "realtime",
      action: "index")
  end

end
