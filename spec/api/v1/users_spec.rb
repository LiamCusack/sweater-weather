require "rails_helper"

describe "Users API" do
  describe "Happy Paths" do
    it "exposes api that allows user creation" do
      user_params = ({
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
        })
      headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}

      post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params, symbolize_names: true)

      expect(response).to be_successful
      expect(create_user.email).to eq(user_params)
    end
  end
end
