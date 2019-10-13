require 'rails_helper'

RSpec.describe "routing to photos" do

  it "routes http://dyl.anjon.es/photos to photos" do
    expect(get: "http://dyl.anjon.es/photos").to route_to(
      controller: "photos",
      action: "index")
  end

end
