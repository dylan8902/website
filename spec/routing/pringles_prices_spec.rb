require 'rails_helper'

RSpec.describe "routing to pringles_prices" do

  it "routes http://dyl.anjon.es/pringles to pringles_prices" do
    expect(get: "http://dyl.anjon.es/pringles").to route_to(
      controller: "pringles_prices",
      action: "index")
  end

end
