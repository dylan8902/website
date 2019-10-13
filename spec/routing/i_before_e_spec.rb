require 'rails_helper'

RSpec.describe "routing to i_before_e" do

  it "routes http://dyl.anjon.es/IbeforeE to i_before_e" do
    expect(get: "http://dyl.anjon.es/IbeforeE").to route_to(
      controller: "i_before_e",
      action: "index")
  end

end
