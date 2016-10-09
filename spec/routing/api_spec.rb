require 'rails_helper'

RSpec.describe "routing to api" do

  it "routes http://dyl.anjon.es/api to api" do
    expect(get: "http://dyl.anjon.es/api").to route_to(
      url: "api",
      path: "api",
      controller: "api",
      action: "index")
  end

end
