require 'rails_helper'

RSpec.describe "routing to bank_transactions" do

  it "routes http://dyl.anjon.es/bank to bank_transactions" do
    expect(get: "http://dyl.anjon.es/bank").to route_to(
      controller: "bank_transactions",
      action: "index")
  end

end
