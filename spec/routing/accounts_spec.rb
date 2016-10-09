require 'rails_helper'

RSpec.describe "routing to accounts" do

  it "routes http://dyl.anjon.es/accounts to accounts" do
    expect(get: "http://dyl.anjon.es/accounts").to route_to(
      url: "accounts",
      path: "accounts",
      controller: "accounts",
      action: "index")
  end

end
