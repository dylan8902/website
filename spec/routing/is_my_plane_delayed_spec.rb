require 'rails_helper'

RSpec.describe "routing to is_my_plane_delayed" do

  it "routes http://ismyplanedelayed.com/ to is_my_plane_delayed" do
    expect(get: "http://ismyplanedelayed.com/").to route_to(
      controller: "is_my_plane_delayed",
      action: "departures")
  end

end
