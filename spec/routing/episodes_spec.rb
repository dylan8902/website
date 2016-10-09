require 'rails_helper'

RSpec.describe "routing to episodes" do

  it "routes http://dyl.anjon.es/episodes to episodes" do
    expect(get: "http://dyl.anjon.es/episodes").to route_to(
      url: "episodes",
      path: "episodes",
      controller: "episodes",
      action: "index")
  end

end
