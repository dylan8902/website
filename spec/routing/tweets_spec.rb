require 'rails_helper'

RSpec.describe "routing to tweets" do

  it "routes http://dyl.anjon.es/tweets to tweets" do
    expect(get: "http://dyl.anjon.es/tweets").to route_to(
      url: "tweets",
      path: "tweets",
      controller: "tweets",
      action: "index")
  end

end
