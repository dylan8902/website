require 'rails_helper'

RSpec.describe "routing to text_messages" do

  it "routes http://dyl.anjon.es/sms to text_messages" do
    expect(get: "http://dyl.anjon.es/sms").to route_to(
      controller: "text_messages",
      action: "index")
  end

end
