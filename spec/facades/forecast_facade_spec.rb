require 'rails_helper'

describe ForecastFacade, :vcr do
  describe "class methods" do
    it "find_location" do
      location = ForecastFacade.find_location("Denver, CO")
      binding.pry

      expect(location).to be_a(Hash)
      expect(location.keys).to eq([:info, :options, :results])
    end

    it "get_coordinates" do
    end

    it "get_weather" do
    end

    it "find_forecast" do
    end

    it "store_weather" do
    end

    it "make_forecast" do
    end

    it "make_current" do
    end

    it "make_daily"  do
    end

    it "make_hourly" do
    end
  end
end
