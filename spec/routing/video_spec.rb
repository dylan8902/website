require 'rails_helper'

RSpec.describe "routing to video" do

  it "routes http://dyl.anjon.es/video to video" do
    expect(get: "http://dyl.anjon.es/video").to route_to(
      controller: "video",
      action: "index")
  end

end
