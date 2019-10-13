require 'rails_helper'

RSpec.describe "routing to tweets" do

  it "routes http://dyl.anjon.es/tweets to tweets" do
    expect(get: "http://dyl.anjon.es/tweets").to route_to(
      controller: "tweets",
      action: "index")
  end

end
