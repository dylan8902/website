require 'rails_helper'

RSpec.describe "routing to stream" do

  it "routes http://dyl.anjon.es/stream to stream" do
    expect(get: "http://dyl.anjon.es/stream").to route_to(
      controller: "stream",
      action: "index")
  end

end
