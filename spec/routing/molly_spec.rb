require 'rails_helper'

RSpec.describe "routing to molly" do

  it "routes http://dyl.anjon.es/molly to molly" do
    expect(get: "http://dyl.anjon.es/molly").to route_to(
      controller: "molly",
      action: "index")
  end

end
