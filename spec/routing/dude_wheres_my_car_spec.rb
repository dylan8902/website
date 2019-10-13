require 'rails_helper'

RSpec.describe "routing to dude_wheres_my_car" do

  it "routes http://dyl.anjon.es/dudewheresmycar to dude_wheres_my_car" do
    expect(get: "http://dyl.anjon.es/dudewheresmycar").to route_to(
      controller: "dude_wheres_my_car",
      action: "index")
  end

end
