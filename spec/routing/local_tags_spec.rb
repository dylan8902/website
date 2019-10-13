require 'rails_helper'

RSpec.describe "routing to local_tags" do

  it "routes http://dyl.anjon.es/localtags to local_tags" do
    expect(get: "http://dyl.anjon.es/localtags").to route_to(
      controller: "local_tags",
      action: "index")
  end

end
