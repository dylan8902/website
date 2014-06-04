require 'spec_helper.rb'

describe BusStop do

  before do
    @bus_stop = BusStop.new(
      common_name: "common",
      locality_name: "locality"
    )
  end


  describe "to string method" do
    
    describe "where there is no parent name" do
      it { @bus_stop.to_s.should eq("common, locality") }
    end
    
    describe "where there is a parent name" do
      before { @bus_stop.parent_locality_name = "parent" }
      it { @bus_stop.to_s.should eq("common, locality, parent") }
    end

  end


end