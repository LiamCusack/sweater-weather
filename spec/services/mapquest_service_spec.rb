require 'rails_helper'

describe MapquestService, :vcr do
  describe "class methods" do
    it 'find_location' do
      location = MapquestService.find_location("Denver, CO")

      expect(location).to be_a(Hash)
      expect(location[:results][0]).to have_key(:urls)
      expect(location[:results][0]).to have_key(:user)
      expect(location[:results][0][:urls]).to have_key(:full)
      expect(location[:results][0][:urls][:full]).to be_a(String)
      expect(location[:results][0][:user]).to have_key(:name)
      expect(location[:results][0][:user][:name]).to be_a(String)
    end

    it 'get_directions' do
      directions = MapquestService.retrieve_directions("Denver,CO", "Pueblo,CO")

      expect(directions).to be_a(Hash)
      expect(directions[:results][0]).to have_key(:urls)
      expect(directions[:results][0]).to have_key(:user)
      expect(directions[:results][0][:urls]).to have_key(:full)
      expect(directions[:results][0][:urls][:full]).to be_a(String)
      expect(directions[:results][0][:user]).to have_key(:name)
      expect(directions[:results][0][:user][:name]).to be_a(String)
    end
  end
end
