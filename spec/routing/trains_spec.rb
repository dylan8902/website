require 'rails_helper'

RSpec.describe "routing to trains" do

  it "routes http://dyl.anjon.es/trains to trains" do
    expect(get: "http://dyl.anjon.es/trains").to route_to(
      controller: "trains",
      action: "index")
  end

end
