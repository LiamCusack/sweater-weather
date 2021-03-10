require 'rails_helper'

describe MapquestService, :vcr do
  describe "class methods" do
    it 'find_location' do
      location = MapquestService.find_location("Denver, CO")
      
      expect(location).to be_a(Hash)
      expect(location[:results][0][:locations][0]).to have_key(:latLng)
      expect(location[:results][0][:locations][0]).to be_a(Hash)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
      expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
      expect(location[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
    end

    it 'get_directions' do
      directions = MapquestService.get_directions("Denver,CO", "Pueblo,CO")

      expect(directions).to be_a(Hash)
      expect(directions[:route]).to have_key(:formattedTime)
      expect(directions[:route][:formattedTime]).to be_a(String)
    end
  end
end
