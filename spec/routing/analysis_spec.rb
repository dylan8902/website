require 'rails_helper'

RSpec.describe "routing to analysis" do

  it "routes http://dyl.anjon.es/analysis to analysis" do
    expect(get: "http://dyl.anjon.es/analysis").to route_to(
      url: "analysis",
      path: "analysis",
      controller: "analysis",
      action: "index")
  end

end
