require 'rails_helper'

RSpec.describe "routing to first_aid" do

  it "routes http://dyl.anjon.es/first-aid to first_aid" do
    expect(get: "http://dyl.anjon.es/first-aid").to route_to(
      url: "first-aid",
      path: "first-aid",
      controller: "first_aid",
      action: "index")
  end

end
