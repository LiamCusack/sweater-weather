class Api::V1::TrailsController < ApplicationController
  def index
    trails = TrailsFacade.get_trip_itinerary(params[:start], params[:destination], params[:minimum_steps])
  end
end
