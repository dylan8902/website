require 'rails_helper'

RSpec.describe "routing to jewellery" do

  it "routes http://dyl.anjon.es/jewellery to jewellery" do
    expect(get: "http://dyl.anjon.es/jewellery").to route_to(
      url: "jewellery",
      path: "jewellery",
      controller: "jewellery",
      action: "index")
  end

end
