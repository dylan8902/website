require 'rails_helper'

RSpec.describe "routing to clock" do

  it "routes http://dyl.anjon.es/clock to clock" do
    expect(get: "http://dyl.anjon.es/clock").to route_to(
      url: "clock",
      path: "clock",
      controller: "clock",
      action: "index")
  end

end
