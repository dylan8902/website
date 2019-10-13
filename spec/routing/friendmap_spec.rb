require 'rails_helper'

RSpec.describe "routing to friendmap" do

  it "routes http://dyl.anjon.es/friendmap to friendmap" do
    expect(get: "http://dyl.anjon.es/friendmap").to route_to(
      controller: "friendmap",
      action: "index")
  end

end
