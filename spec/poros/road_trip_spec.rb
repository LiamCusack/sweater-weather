require 'rails_helper'

describe RoadTrip, :vcr do
  it 'attributes' do
    image = UnsplashService.retrieve_image("Denver, CO")
    background = Background.new(image, "Denver, CO")

    expect(background).to be_a(Background)
    expect(background.image_url).to eq(image[:results][0][:urls][:full])
    expect(background.photographer).to eq(image[:results][0][:user][:name])
    expect(background.location).to eq("Denver, CO")
  end
end
