class Api::V1::ForecastController < ApplicationController
  def index
    forcast = ForecastFacade.find_forecast(params[:location])
    binding.pry
    render json: ForecastSerializer.new(forcast)

  end
end
