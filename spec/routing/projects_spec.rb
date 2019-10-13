require 'rails_helper'

RSpec.describe "routing to projects" do

  it "routes http://dyl.anjon.es/stuff to projects" do
    expect(get: "http://dyl.anjon.es/stuff").to route_to(
      controller: "projects",
      action: "index")
  end

end
