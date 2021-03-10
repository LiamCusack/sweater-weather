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
      expect(created_user.email).to eq(user_params[:email])
      expect(created_user.password).to eq(user_params[:password])
      expect(created_user.password_confirmation).to eq(user_params[:password_confirmation])
    end
  end
end
