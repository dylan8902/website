require 'rails_helper'

RSpec.describe "routing to convicts" do

  it "routes http://dyl.anjon.es/nhtg11 to convicts" do
    expect(get: "http://dyl.anjon.es/nhtg11").to route_to(
      url: "nhtg11",
      path: "nhtg11",
      controller: "convicts",
      action: "index")
  end

end
