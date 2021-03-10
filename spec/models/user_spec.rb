require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "Instance Methods" do
    it "authenticate_password" do
      jerry = User.create(email: "hi@hi.hi", password: "banana", password_confirmation: "banana")
      params[:password] = "banana"
      
      expect(jerry.authenticate_password(params[:password])).to eq(true)
    end
  end
end
