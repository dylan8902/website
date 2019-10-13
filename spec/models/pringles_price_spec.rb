require 'rails_helper.rb'

RSpec.describe PringlesPrice do

  describe "parsing the tesco offer" do

    it "return the original price for no offer" do
      p = { "PromotionDescription" => "", "price" => 2.48 }
      expect(PringlesPrice.parse_tesco_offer(p)).to eq(2.48)
    end

    it "offer price for a 2 for £3" do
      p = {"PromotionDescription" => "Any 2 for £3.00", "price" => 2.48 }
      expect(PringlesPrice.parse_tesco_offer(p)).to eq(1.50)
    end

  end

end
