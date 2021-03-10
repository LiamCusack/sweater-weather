class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: roadtrip_params[:api_key])
    if user
    roadtrip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
    render json: RoadTripSerializer.new(roadtrip)
  end

  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end
end
