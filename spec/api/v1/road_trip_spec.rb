require "rails_helper"

describe "Road Trip API" do
  describe "Happy Paths" do
    it "it can make a road trip" do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "jgn983hy48thw9begh98h435"
      }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/road_trip", headers: headers, params: body.to_json

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(road_trip).to be_a(Hash)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:id]).to eq(User.last.id.to_s)
      expect(road_trip[:data][:type]).to eq("roadtrip")
      expect(road_trip[:data][:attributes]).to be_a(Hash)
      expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(road_trip[:data][:attributes][:start_city]).to eq(body[:origin])
      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to eq(body[:destination])
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(YO THIS IS SOME KIND OF OBJECT)
      expect(road_trip[:data][:attributes][:weather_at_eta].keys).to eq(:temperature, :conditions, :note)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta][:note]).to be_a(WHO KNOWS?)
    end
  end
end
