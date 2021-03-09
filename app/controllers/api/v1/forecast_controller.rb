class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].present?
      forcast = ForecastFacade.find_forecast(params[:location])

      render json: ForecastSerializer.new(forcast)
    else
      render json: { error: "Parameters missing" }
    end
  end
end
