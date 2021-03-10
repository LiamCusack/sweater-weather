require 'rails_helper'

describe RoadTrip, :vcr do
  it 'attributes' do
    roadtrip = RoadTrip.new({}, "Denver,CO", "England", "impossible route")

    expect(roadtrip).to be_a(RoadTrip)
    expect(roadtrip.start_city).to eq("Denver,CO")
    expect(roadtrip.end_city).to eq("England")
    expect(roadtrip.travel_time).to eq("impossible route")
    expect(roadtrip.weather_at_eta).to be_a(Hash)
  end
end
