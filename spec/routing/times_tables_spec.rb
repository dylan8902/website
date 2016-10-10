require 'rails_helper'

RSpec.describe "routing to times_tables" do

  it "routes http://dyl.anjon.es/timestables to times_tables" do
    expect(get: "http://dyl.anjon.es/timestables").to route_to(
      url: "timestables",
      path: "timestables",
      controller: "times_tables",
      action: "index")
  end

end
