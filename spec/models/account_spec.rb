require 'spec_helper.rb'

describe Account do

  before do
    @account = Account.new
  end

  describe "not valid when no name" do
    it { expect(@account.valid?).to eq(false) }
  end

end