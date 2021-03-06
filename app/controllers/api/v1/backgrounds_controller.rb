class Api::V1::BackgroundsController < ApplicationController
  def index
    if params[:location].present?
      background = BackgroundsFacade.get_background(params[:location])

      render json: BackgroundsSerializer.new(background)
    else
      render json: { error: "Parameters missing" }
    end
  end
end
