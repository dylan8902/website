require 'rails_helper'

RSpec.describe "routing to deep_dive" do

  it "routes http://dyl.anjon.es/deepdive to deep_dive" do
    expect(get: "http://dyl.anjon.es/deepdive").to route_to(
      url: "deepdive",
      path: "deepdive",
      controller: "deep_dive",
      action: "index")
  end

end
