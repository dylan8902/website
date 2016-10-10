require 'rails_helper'

RSpec.describe "routing to is_my_bus_delayed" do

  it "routes http://ismybusdelayed.com/ to is_my_bus_delayed" do
    expect(get: "http://ismybusdelayed.com/").to route_to(
      controller: "is_my_bus_delayed",
      action: "index")
  end

end
