require "rails_helper"

describe "Users API" do
  describe "Happy Paths" do
    it "can create a new user" do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json
      created_user = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(created_user).to be_a(Hash)
      expect(created_user[:data].keys).to eq([:id, :type, :attributes])
      expect(created_user[:data][:id]).to eq(User.last.id.to_s)
      expect(created_user[:data][:type]).to eq("users")
      expect(created_user[:data][:attributes]).to be_a(Hash)
      expect(created_user[:data][:attributes].keys).to eq([:email, :api_key])
      expect(created_user[:data][:attributes][:email]).to eq(body[:email])
      expect(created_user[:data][:attributes][:email]).to be_a(String)
      expect(created_user[:data][:attributes][:api_key]).to be_a(String)
    end
  end
  describe 'Sad Paths' do
    it "returns an error if passwords do not match" do
      body = {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "NOTTHESAME"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to be(400)
      expect(json[:error]).to eq("Bad Request: passwords do not match")
    end

    it "returns an error if the email is already taken" do
      body1 = {
        "email": "original@original.com",
        "password": "password",
        "password_confirmation": "password"
        }
      body2 = {
        "email": "original@original.com",
        "password": "password",
        "password_confirmation": "password"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body1.to_json
      post "/api/v1/users", headers: headers, params: body2.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to be(400)
      expect(json[:error]).to eq("Bad Request: email is already taken")
    end

    it "returns an error if the email field is blank" do
      body = {
        "email": "",
        "password": "password",
        "password_confirmation": "password"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to be(400)
      expect(json[:error]).to eq("Bad Request: email cannot be blank")
    end

    it "returns an error if the email field is blank" do
      body = {
        "email": "email@email.email",
        "password": "",
        "password_confirmation": "password"
        }
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: body.to_json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to be(400)
      expect(json[:error]).to eq("Bad Request: password cannot be blank")
    end

    it "returns an error if you try to pass params in url" do
      post "/api/v1/users?email=email@email.email&password=noperonis&password_confirmation=noperonies"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to be(401)
      expect(json[:error]).to eq("Unauthorized: You shall not pass... parameters through the url")
    end
  end
end
