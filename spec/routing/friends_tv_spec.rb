require 'rails_helper'

RSpec.describe "routing to friends_tv" do

  it "routes http://dyl.anjon.es/friendstv to friends_tv" do
    expect(get: "http://dyl.anjon.es/friendstv").to route_to(
      url: "friendstv",
      path: "friendstv",
      controller: "friends_tv",
      action: "index")
  end

end
