require 'rails_helper'

RSpec.describe "routing to analytics" do

  it "routes http://dyl.anjon.es/analytics to analytics" do
    expect(get: "http://dyl.anjon.es/analytics").to route_to(
      controller: "analytics",
      action: "index")
  end

end
