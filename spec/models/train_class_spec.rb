require 'spec_helper.rb'

RSpec.describe Trains::TrainClass do

  it "is the right class" do
    expect(Trains::TrainClass.table_name).to eq("train_classes")
  end

end