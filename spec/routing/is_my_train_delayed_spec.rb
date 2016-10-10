require 'rails_helper'

RSpec.describe "routing to is_my_train_delayed" do

  it "routes http://ismyplanedelayed.com/ to is_my_train_delayed" do
    expect(get: "http://ismytraindelayed.com/").to route_to(
      controller: "is_my_train_delayed",
      action: "departures")
  end

end
