require 'rails_helper'

describe "Trails API" do
  describe "Happy Path" do
    it "gets you a trip log to a trail desribing duration, forecast, and trail data", :vcr do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get "/api/v1/trails?start=Santa+Fe&destination=Albuquerque&minimum_steps=1000"

      expect(response).to be_successful
      trail = JSON.parse(response.body, symbolize_names: true)

      expect(trail).to be_a(Hash)
      expect(trail[:data]).to be_a(Array)
      expect(trail[:data].first).to be_a(Hash)
      expect(trail[:data][0].keys).to eq(:id, :type, :attributes)
      expect(trail[:data][0][:id]).to be_a(Integer)
      expect(trail[:data][0][:type]).to eq("trail")
      expect(trail[:data][0][:attributes]).to be_a(Hash)
      expect(trail[:data][0][:attributes].keys).to eq([:trail_name, :travel_time, :difficulty, :parking, :loops, :forecast])
      expect(trail[:data][0][:attributes][:trail_name]).to be_a(String)
      expect(trail[:data][0][:attributes][:travel_time]).to be_a(String)
      expect(trail[:data][0][:attributes][:difficulty]).to be_a(Integer)
      expect(trail[:data][0][:attributes][:parking]).to be_a(String)
      expect(trail[:data][0][:attributes][:loops].keys).to eq([:"1"])
      expect(trail[:data][0][:attributes][:loops][:"1"]).to be_a(Hash)
      expect(trail[:data][0][:attributes][:loops][:"1"].keys).to eq([:name, :distance, :steps])
      expect(trail[:data][0][:attributes][:loops][:"1"][:name]).to be_a(String)
      expect(trail[:data][0][:attributes][:loops][:"1"][:distance]).to be_a(String)
      expect(trail[:data][0][:attributes][:loops][:"1"][:steps]).to be_a(Integer)
      expect(trail[:data][0][:attributes][:forecast]).to be_a(Hash)
      expect(trail[:data][0][:attributes][:forecast].keys).to eq([:summary, :temperature])
      expect(trail[:data][0][:attributes][:forecast][:summary]).to be_a(String)
      expect(trail[:data][0][:attributes][:forecast][:temperature]).to be_a(String)
    end
  end

  describe "Sad Paths" do
    it "returns an error if you give bad params" do
    end
  end
end
