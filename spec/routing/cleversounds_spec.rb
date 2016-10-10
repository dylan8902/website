require 'rails_helper'

RSpec.describe "routing to cleversounds" do

  it "routes http://dyl.anjon.es/cleversounds to cleversounds" do
    expect(get: "http://dyl.anjon.es/cleversounds").to route_to(
      url: "cleversounds",
      path: "cleversounds",
      controller: "cleversounds",
      action: "index")
  end

end
