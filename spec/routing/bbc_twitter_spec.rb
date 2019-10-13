require 'rails_helper'

RSpec.describe "routing to bbc_twitter" do

  it "routes http://dyl.anjon.es/bbc-twitter to bbc_twitter" do
    expect(get: "http://dyl.anjon.es/bbc-twitter").to route_to(
      controller: "bbc_twitter",
      action: "index")
  end

end
