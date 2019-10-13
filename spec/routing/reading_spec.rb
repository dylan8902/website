require 'rails_helper'

RSpec.describe "routing to reading" do

  it "routes http://dyl.anjon.es/reading to reading" do
    expect(get: "http://dyl.anjon.es/reading").to route_to(
      controller: "reading",
      action: "index")
  end

end
