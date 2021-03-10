require 'rails_helper'

describe UnsplashService, :vcr do
  describe "class methods" do
    it 'retrieve_image' do
      image = UnsplashService.retrieve_image("Denver, CO")

      expect(image).to be_a(Hash)
      expect(image[:results][0]).to have_key(:urls)
      expect(image[:results][0]).to have_key(:user)
      expect(image[:results][0][:urls]).to have_key(:full)
      expect(image[:results][0][:urls][:full]).to be_a(String)
      expect(image[:results][0][:user]).to have_key(:name)
      expect(image[:results][0][:user][:name]).to be_a(String)
    end
  end
end
