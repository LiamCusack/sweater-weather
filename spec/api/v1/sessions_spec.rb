require "rails_helper"

describe "Sessions API" do
  describe "Happy Paths" do
    before :each do
      body = {
        "email": "unique@new.com",
        "password": "bananas",
        "password_confirmation": "bananas"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json

      @user = JSON.parse(response.body, symbolize_names: true)
    end

    it "can create a new session" do
      body = {
        "email": "whatever@example.com",
        "password": "password"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/sessions", headers: headers, params: body.to_json
      created_session = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(created_session).to be_a(Hash)
      expect(created_session[:data].keys).to eq([:id, :type, :attributes])
      expect(created_session[:data][:id]).to eq(Session.last.id.to_s)
      expect(created_session[:data][:type]).to eq("sessions")
      expect(created_session[:data][:attributes]).to be_a(Hash)
      expect(created_session[:data][:attributes].keys).to eq([:email, :api_key])
      expect(created_session[:data][:attributes][:email]).to eq(body[:email])
      expect(created_session[:data][:attributes][:api_key]).to be_a(String)
    end
  end
  describe 'Sad Paths' do
  end
end
