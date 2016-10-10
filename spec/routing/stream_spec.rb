require 'rails_helper'

RSpec.describe "routing to stream" do

  it "routes http://dyl.anjon.es/stream to stream" do
    expect(get: "http://dyl.anjon.es/stream").to route_to(
      url: "stream",
      path: "stream",
      controller: "stream",
      action: "index")
  end

end
