require 'rails_helper'

RSpec.describe "routing to pub_thursday" do

  it "routes http://dyl.anjon.es/pubthursday to pub_thursday" do
    expect(get: "http://dyl.anjon.es/pubthursday").to route_to(
      controller: "pub_thursday",
      action: "challenge")
  end

end
