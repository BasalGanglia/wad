require 'rails_helper'

RSpec.describe Beer, type: :model do
 it "has the username set correctly" do
    beer = Beer.new name:"Karhu"

   beer.name.should == "Karhu"
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Karhu"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

   describe "with a proper style" do
    let(:beer){ Beer.create name:"Karhu", style: "Lager"}

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
    end


end
