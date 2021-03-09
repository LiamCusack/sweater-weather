require 'rails_helper'

describe "Forcast API" do
  describe "Happy Path" do
    it "retrieves a weather forcast for a given city", :vcr do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)
      expect(data[:data].keys).to eq(:id, :type, :attributes)
      expect(data[:data][0][:id]).to be_a(Integer)
      expect(data[:data][0][:type]).to eq("forecast")
      expect(data[:data][0][:attributes]).to be_a(Hash)
      expect(data[:data][0][:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(data[:data][0][:attributes][:data_name]).to be_a(String)
      expect(data[:data][0][:attributes][:travel_time]).to be_a(String)
      expect(data[:data][0][:attributes][:difficulty]).to be_a(Integer)
      expect(data[:data][0][:attributes][:parking]).to be_a(String)
      expect(data[:data][0][:attributes][:loops].keys).to eq([:"1"])
      expect(data[:data][0][:attributes][:loops][:"1"]).to be_a(Hash)
      expect(data[:data][0][:attributes][:loops][:"1"].keys).to eq([:name, :distance, :steps])
      expect(data[:data][0][:attributes][:loops][:"1"][:name]).to be_a(String)
      expect(data[:data][0][:attributes][:loops][:"1"][:distance]).to be_a(String)
      expect(data[:data][0][:attributes][:loops][:"1"][:steps]).to be_a(Integer)
      expect(data[:data][0][:attributes][:forecast]).to be_a(Hash)
      expect(data[:data][0][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(data[:data][0][:attributes][:forecast][:summary]).to be_a(String)
      expect(data[:data][0][:attributes][:forecast][:temperature]).to be_a(String)
    end
  end
