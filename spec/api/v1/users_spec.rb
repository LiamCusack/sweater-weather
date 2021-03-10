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
      created_user = User.last
      binding.pry

      expect(response).to be_successful
      expect(created_user.email).to eq(body[:email])
      expect(created_user.password).to eq(body[:password])
      expect(created_user.password).to eq(body[:password_confirmation])
    end
  end
end
