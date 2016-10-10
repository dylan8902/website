require 'rails_helper'

RSpec.describe "routing to running_events" do

  it "routes http://dyl.anjon.es/running to running_events" do
    expect(get: "http://dyl.anjon.es/running").to route_to(
      url: "running",
      path: "running",
      controller: "running_events",
      action: "index")
  end

end
