require 'rails_helper'

RSpec.describe "routing to convicts" do

  it "routes http://dyl.anjon.es/nhtg11 to convicts" do
    expect(get: "http://dyl.anjon.es/nhtg11").to route_to(
      controller: "convicts",
      action: "index")
  end

end
