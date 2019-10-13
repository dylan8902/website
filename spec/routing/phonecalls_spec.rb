require 'rails_helper'

RSpec.describe "routing to phonecalls" do

  it "routes http://dyl.anjon.es/phonecalls to phonecalls" do
    expect(get: "http://dyl.anjon.es/phonecalls").to route_to(
      controller: "phonecalls",
      action: "index")
  end

end
