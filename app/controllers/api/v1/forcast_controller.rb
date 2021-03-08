class Api::V1::ForcastController < ApplicationController
  def location_weather
    @location = ForcastFacade.find_location(params[:location])
  end
end
