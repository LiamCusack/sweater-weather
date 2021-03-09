require 'rails_helper'

describe ForecastFacade, :vcr do
  describe "class methods" do
    before :each do
      @location = ForecastFacade.find_location("Denver, CO")
      @coordinates = ForecastFacade.get_coordinates(@location)
      @weather = ForecastFacade.get_weather(@coordinates)
      @forecast = ForecastFacade.find_forecast("Denver, CO")
      @current = ForecastFacade.make_current(@weather[:current])
      @daily = ForecastFacade.make_daily(@weather[:daily])
      @hourly = ForecastFacade.make_hourly(@weather[:hourly])
    end
    it "find_location" do

      expect(@location).to be_a(Hash)
      expect(@location.keys).to eq([:info, :options, :results])
      expect(@location[:results][0][:locations][0]).to have_key(:latLng)
      expect(@location[:results][0][:locations][0][:latLng].keys).to eq([:lat, :lng])
    end

    it "get_coordinates" do

      expect(@coordinates).to be_a(Hash)
      expect(@coordinates).to have_key(:lat)
      expect(@coordinates).to have_key(:lng)
    end

    it "get_weather" do

      expect(@weather).to be_a(Hash)
      expect(@weather).to have_key(:lat)
      expect(@weather).to have_key(:lon)
      expect(@weather).to have_key(:timezone)
      expect(@weather).to have_key(:timezone_offset)
      expect(@weather).to have_key(:current)
      expect(@weather).to have_key(:hourly)
      expect(@weather).to have_key(:daily)
      expect(@weather).not_to have_key(:minutely)
    end

    it "find_forecast" do

      expect(@forecast).to be_a(Forecast)
    end

    it "store_weather" do
      store_weather = ForecastFacade.store_weather(@weather)

      expect(store_weather).to be_a(Forecast)
    end

    it "make_forecast" do
      make_forecast = ForecastFacade.make_forecast(@current, @daily, @hourly)

      expect(make_forecast).to be_a(Forecast)
    end

    it "make_current" do

      expect(@current).to be_a(CurrentWeather)
    end

    it "make_daily"  do

      @daily.each do |daily|
        expect(daily).to be_a(DailyWeather)
      end
    end

    it "make_hourly" do

      @hourly.each do |hourly|
        expect(hourly).to be_a(HourlyWeather)
      end
    end
  end
end
