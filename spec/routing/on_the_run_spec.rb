require 'rails_helper'

RSpec.describe "routing to on_the_run" do

  it "routes http://dyl.anjon.es/ontherun to on_the_run" do
    expect(get: "http://dyl.anjon.es/ontherun").to route_to(
      url: "ontherun",
      path: "ontherun",
      controller: "on_the_run",
      action: "index")
  end

end
