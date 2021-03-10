require 'rails_helper'

describe RoadTripFacade, :vcr do
  describe "class methods" do
    it "create_road_trip" do
      roadtrip = RoadTripFacade.create_road_trip("Denver,CO", "Pueblo,CO")

      expect(roadtrip).to be_a(RoadTrip)
    end
  end
end
