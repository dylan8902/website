require 'rails_helper'

RSpec.describe "routing to md5" do

  it "routes http://dyl.anjon.es/md5 to md5" do
    expect(get: "http://dyl.anjon.es/md5").to route_to(
      url: "md5",
      path: "md5",
      controller: "md5",
      action: "index")
  end

end
