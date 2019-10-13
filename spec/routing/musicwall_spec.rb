require 'rails_helper'

RSpec.describe "routing to musicwall" do

  it "routes http://dyl.anjon.es/musicwall to musicwall" do
    expect(get: "http://dyl.anjon.es/musicwall").to route_to(
      controller: "musicwall",
      action: "index")
  end

end
