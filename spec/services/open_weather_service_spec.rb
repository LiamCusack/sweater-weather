require 'rails_helper'

describe OpenWeatherService, :vcr do
  describe "class methods" do
    it 'retrieve_image' do
      forecast = OpenWeatherService.retrieve_image("Denver, CO")

      expect(forecast).to be_a(Hash)
      expect(forecast[:results][0]).to have_key(:urls)
      expect(forecast[:results][0]).to have_key(:user)
      expect(forecast[:results][0][:urls]).to have_key(:full)
      expect(forecast[:results][0][:urls][:full]).to be_a(String)
      expect(forecast[:results][0][:user]).to have_key(:name)
      expect(forecast[:results][0][:user][:name]).to be_a(String)
    end
  end
end
