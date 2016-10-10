require 'rails_helper'

RSpec.describe "routing to on_radio" do

  it "routes http://dyl.anjon.es/onradio/1 to on_radio" do
    expect(get: "http://dyl.anjon.es/onradio/1").to route_to(
      url: "onradio/1",
      path: "onradio/1",
      controller: "on_radio",
      action: "one")
  end

end
