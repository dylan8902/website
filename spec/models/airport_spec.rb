require 'spec_helper.rb'

describe Airport do

  before do
    @airport = Airport.new
    @airport.name = "Test"
    @airport.city = "City"
    @airport.country = "Country"
  end

  describe "the to string method" do
    subject { @airport.to_s }
    it { should eq("Test (City, Country)") }
  end

  describe "the tmap marker text" do
    subject { @airport.map_marker_text }
    it { should eq("Test (City, Country)") }
  end

end