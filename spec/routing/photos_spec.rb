require 'rails_helper'

RSpec.describe "routing to photos" do

  it "routes http://dyl.anjon.es/photos to pdfy" do
    expect(get: "http://dyl.anjon.es/photos").to route_to(
      url: "photos",
      path: "photos",
      controller: "photos",
      action: "index")
  end

end
