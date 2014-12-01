require 'spec_helper.rb'

describe Trains::TrainClass do

  describe "the table is train_classes" do
    it { expect(Trains::TrainClass.table_name).to eq("train_classes") }
  end

end