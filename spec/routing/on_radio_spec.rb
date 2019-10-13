require 'rails_helper'

RSpec.describe "routing to on_radio" do

  it "routes http://dyl.anjon.es/onradio/1 to on_radio" do
    expect(get: "http://dyl.anjon.es/onradio/1").to route_to(
      controller: "on_radio",
      action: "one")
  end

end
