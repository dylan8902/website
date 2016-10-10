require 'rails_helper'

RSpec.describe "routing to pay_a_pal" do

  it "routes http://dyl.anjon.es/payapal to pay_a_pal" do
    expect(get: "http://dyl.anjon.es/payapal").to route_to(
      url: "payapal",
      path: "payapal",
      controller: "pay_a_pal",
      action: "index")
  end

end
