class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: roadtrip_params[:api_key])
    if user.present? && params[:origin].present? && params[:destination].present?
      roadtrip = RoadTripFacade.create_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(roadtrip), status: 201
    elsif (params[:origin] || params[:destination]) == ""
      self.status_400
    else
      self.unauthorized_api_key
    end
  end

  private

  def roadtrip_params
    params.permit(:origin, :destination, :api_key)
  end
end
