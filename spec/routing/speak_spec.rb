require 'rails_helper'

RSpec.describe "routing to speak" do

  it "routes http://dyl.anjon.es/speak to speak" do
    expect(get: "http://dyl.anjon.es/speak").to route_to(
      controller: "speak",
      action: "index")
  end

end
