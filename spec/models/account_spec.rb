require 'rails_helper.rb'

RSpec.describe Account do

  before do
    @account = Account.new
  end

  it "is not valid without a name" do
    expect(@account.valid?).to eq(false)
  end

end