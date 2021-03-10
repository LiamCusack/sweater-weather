require 'rails-helper'

describe UnsplashService, :vcr do
  describe "class methods" do
    it 'retrieve_image' do
      image = UnsplashService.retrieve_image("Denver, CO")

      expect(image).to be_a(Hash)
      expect(image[:results]).to have_key(:urls)
      expect(image[:results]).to have_key(:user)
      expect(image[:results][:urls]).to have_key(:full)
      expect(image[:results][:urls][:full]).to be_a(String)
      expect(image[:results][:user]).to have_key(:name)
      expect(image[:results][:user][:name]).to be_a(:string)
    end
  end
end
