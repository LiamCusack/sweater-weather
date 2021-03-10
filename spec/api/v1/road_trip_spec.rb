require "rails_helper"

describe "Road Trip API", :vcr do
  describe "Happy Paths" do
    before :each do
      body = {
        "email": "3unique5me@new.com",
        "password": "bananas",
        "password_confirmation": "bananas"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json

      @user = JSON.parse(response.body, symbolize_names: true)
    end

    it "it can make a road trip" do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": @user[:data][:attributes][:api_key]
      }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/road_trip", headers: headers, params: body.to_json

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(road_trip).to be_a(Hash)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:id]).to eq(nil)
      expect(road_trip[:data][:type]).to eq("road_trip")
      expect(road_trip[:data][:attributes]).to be_a(Hash)
      expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(road_trip[:data][:attributes][:start_city]).to eq(body[:origin])
      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to eq(body[:destination])
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
      expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
      expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
    end

    it "can make an impossible roadtrip" do
      body = {
        "origin": "Denver,CO",
        "destination": "England",
        "api_key": @user[:data][:attributes][:api_key]
      }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/road_trip", headers: headers, params: body.to_json

      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(road_trip).to be_a(Hash)
      expect(road_trip[:data].keys).to eq([:id, :type, :attributes])
      expect(road_trip[:data][:id]).to eq(nil)
      expect(road_trip[:data][:type]).to eq("road_trip")
      expect(road_trip[:data][:attributes]).to be_a(Hash)
      expect(road_trip[:data][:attributes].keys).to eq([:start_city, :end_city, :travel_time, :weather_at_eta])
      expect(road_trip[:data][:attributes][:start_city]).to eq(body[:origin])
      expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:end_city]).to eq(body[:destination])
      expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
      expect(road_trip[:data][:attributes][:travel_time]).to eq("impossible route")
      expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end
  describe "Sad Paths" do
    it "returns an error if the api_key is invalid" do
      body = {
        "origin": "Denver,CO",
        "destination": "Pueblo,CO",
        "api_key": "Big Chungus"
      }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/road_trip", headers: headers, params: body.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      expect(json[:error]).to eq("Unauthorized: Api Key is not valid")
    end

    it "returns an error if the origin/destination is missing" do
      body = {
        "origin": "",
        "destination": "Pueblo,CO",
        "api_key": "Big Chungus"
      }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/road_trip", headers: headers, params: body.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(json[:error]).to eq("Bad Request: origin or destination cannot be blank")
    end
  end
end
