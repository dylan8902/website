require 'rails_helper'

RSpec.describe "routing to phonecalls" do

  it "routes http://dyl.anjon.es/phonecalls to pdfy" do
    expect(get: "http://dyl.anjon.es/phonecalls").to route_to(
      url: "phonecalls",
      path: "phonecalls",
      controller: "phonecalls",
      action: "index")
  end

end
