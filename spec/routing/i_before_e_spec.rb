require 'rails_helper'

RSpec.describe "routing to i_before_e" do

  it "routes http://dyl.anjon.es/IbeforeE to friends_tv" do
    expect(get: "http://dyl.anjon.es/IbeforeE").to route_to(
      url: "IbeforeE",
      path: "IbeforeE",
      controller: "i_before_e",
      action: "index")
  end

end
