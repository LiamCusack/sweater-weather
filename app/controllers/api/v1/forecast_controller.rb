class Api::V1::ForecastController < ApplicationController
  def index
    forcast = ForecastFacade.find_forecast(params[:location])

    render json: ForecastSerializer.new(forcast)

  end
end
