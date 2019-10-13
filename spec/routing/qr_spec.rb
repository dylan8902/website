require 'rails_helper'

RSpec.describe "routing to qr" do

  it "routes http://dyl.anjon.es/qr to qr" do
    expect(get: "http://dyl.anjon.es/qr").to route_to(
      controller: "qr",
      action: "index")
  end

end
