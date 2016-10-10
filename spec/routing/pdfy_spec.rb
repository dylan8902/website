require 'rails_helper'

RSpec.describe "routing to pdfy" do

  it "routes http://dyl.anjon.es/pdfy to pdfy" do
    expect(get: "http://dyl.anjon.es/pdfy").to route_to(
      url: "pdfy",
      path: "pdfy",
      controller: "pdfy",
      action: "index")
  end

end
