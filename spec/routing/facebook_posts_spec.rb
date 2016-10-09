require 'rails_helper'

RSpec.describe "routing to facebook_posts" do

  it "routes http://dyl.anjon.es/facebook to facebook_posts" do
    expect(get: "http://dyl.anjon.es/facebook").to route_to(
      url: "facebook",
      path: "facebook",
      controller: "facebook_posts",
      action: "index")
  end

end
