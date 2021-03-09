require 'rails_helper'

describe "Forecast API" do
  describe "Happy Path" do
    it "retrieves a weather forecast for a given city", :vcr do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)
      expect(data[:data]).to have_key(:id)
      expect(data[:data]).to have_key(:type)
      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:id]).to eq(nil)
      expect(data[:data][:type]).to eq("forecast")
      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes].keys).to eq([:id, :current_weather, :daily_weather, :hourly_weather])
    end
  end
  describe "Sad Paths" do
    it "returns error message when given invalid params", :vcr do
      get "/api/v1/forecast?location=dfghjhfdffg"
      binding.pry

      expect(response).to be_successful
    end

    it "returns error when params are blank", :vcr do
      get "/api/v1/forecast?location="

      expect(response).to be_successful
    end

    it "returns an error when this thing happens", :vcr do
      get "/api/v1/forecast?location=#$%^&^"
      binding.pry

      expect(response).to be_successful
    end
  end
end
