require 'spec_helper.rb'

describe Airport do

  before do
    @airport = Airport.new
    @airport.name = "Test"
    @airport.city = "City"
    @airport.country = "Country"
  end

  describe "the to string method" do
    it { expect(@airport.to_s).to eq("Test (City, Country)") }
  end

  describe "the tmap marker text" do
    it { expect(@airport.map_marker_text).to eq("Test (City, Country)") }
  end

end