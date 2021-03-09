require 'rails_helper'

describe "Background API" do
  describe "Happy Path" do
    it "retrieves a background image for a given city", :vcr do
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data[:data]).to be_a(Hash)
      expect(data[:data]).to have_key(:id)
      expect(data[:data]).to have_key(:type)
      expect(data[:data]).to have_key(:attributes)
      expect(data[:data][:id]).to eq(nil)
      expect(data[:data][:type]).to eq("image")
      expect(data[:data][:attributes]).to be_a(Hash)
      expect(data[:data][:attributes].keys).to eq([:image])
    end
  end
end
