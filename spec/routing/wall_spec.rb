require 'rails_helper'

RSpec.describe "routing to wall" do

  it "routes http://dyl.anjon.es/wall to wall" do
    expect(get: "http://dyl.anjon.es/wall").to route_to(
      controller: "wall",
      action: "index")
  end

end
