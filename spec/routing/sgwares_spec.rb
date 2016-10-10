require 'rails_helper'

RSpec.describe "routing to sgwares" do

  it "routes http://dyl.anjon.es/sgwares to sgwares" do
    expect(get: "http://dyl.anjon.es/sgwares").to route_to(
      url: "sgwares",
      path: "sgwares",
      controller: "sgwares",
      action: "index")
  end

end
