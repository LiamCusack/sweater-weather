class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present? && params[:location] != ""
      forcast = ForecastFacade.find_forecast(params[:location])

      render json: ForecastSerializer.new(forcast)
    else params[:location] == ""
      self.status_400
    end
  end
end
