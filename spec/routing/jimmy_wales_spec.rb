require 'rails_helper'

RSpec.describe "routing to jimmy_wales" do

  it "routes http://dyl.anjon.es/jimmywales to jimmy_wales" do
    expect(get: "http://dyl.anjon.es/jimmywales").to route_to(
      controller: "jimmy_wales",
      action: "index")
  end

end
