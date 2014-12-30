require 'rails_helper.rb'

RSpec.describe Airport do

  before do
    @airport = Airport.new
    @airport.name = "Test"
    @airport.city = "City"
    @airport.country = "Country"
  end

  it "should have a nice string with brackets" do
    expect(@airport.to_s).to eq("Test (City, Country)")
  end

  it "should have nice marker text for maps" do
    expect(@airport.map_marker_text).to eq("Test (City, Country)")
  end

end