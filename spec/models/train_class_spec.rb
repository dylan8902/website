require 'spec_helper.rb'

describe Trains::TrainClass do
  
  describe "the table is train_classes" do
    subject { Trains::TrainClass.table_name }
    it { should eq("train_classes") }
  end
  
end