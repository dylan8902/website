require 'rails_helper'

RSpec.describe "routing to drops" do

  it "routes http://dyl.anjon.es/drop to drops" do
    expect(get: "http://dyl.anjon.es/drop").to route_to(
      controller: "drops",
      action: "index")
  end

end
