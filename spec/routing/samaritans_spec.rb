require 'rails_helper'

RSpec.describe "routing to samaritans" do

  it "routes http://dyl.anjon.es/samaritans to samaritans" do
    expect(get: "http://dyl.anjon.es/samaritans").to route_to(
      url: "samaritans",
      path: "samaritans",
      controller: "samaritans",
      action: "index")
  end

end
