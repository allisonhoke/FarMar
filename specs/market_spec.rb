require_relative 'spec_helper'

module FarMar
  describe Market do

    describe "#initialize" do
      let(:new_market) { Market.new({}) }

      it "should create a new instace of Market" do
        new_market.must_be_instance_of(Market)
      end
    end

    describe ".all" do
      it "should return an array" do
        Market.all.must_be_kind_of(Array)
      end

      it "should return an object: Market at any index of the array" do
        Market.all[0].must_be_instance_of(Market)
        Market.all[10].must_be_instance_of(Market)
        Market.all[20].must_be_instance_of(Market)
      end
    end

    describe ".find(id)" do
      it "should return an object: Market with name Scottdale Farmers Market at ID 20" do
        scots = Market.find(20)

        scots.must_be_instance_of(Market)
        scots.name.must_equal("Scottdale Farmers Market")
      end
    end

    describe "#vendors" do
      let(:example_market) { Market.new({id: 4, name: "Allison's Market", address: "address", city: "city", county: "county", state: "state", zip: "zip"}) }

      it "returns an array" do
        example_market.vendors.must_be_kind_of(Array)
      end

      it "should return an object: Vendor at any index of the array" do
        four = example_market.vendors

        four[0].must_be_instance_of(Vendor)
        four[1].must_be_instance_of(Vendor)
        four[2].must_be_instance_of(Vendor)
      end

      it "should return the correct market_id that matches the one searched" do
        four = example_market.vendors

        four[0].market_id.must_equal(4)
        four[1].market_id.must_equal(4)
        four[2].market_id.must_equal(4)
      end
    end
  end
end