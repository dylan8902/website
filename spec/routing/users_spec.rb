require 'rails_helper'

RSpec.describe "routing to users" do

  it "routes http://dyl.anjon.es/users/1 to users" do
    expect(get: "http://dyl.anjon.es/users/1").to route_to(
      id: "1",
      url: "users/1",
      path: "users/1",
      controller: "users",
      action: "show")
  end

end
