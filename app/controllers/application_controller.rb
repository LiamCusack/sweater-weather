class ApplicationController < ActionController::API
  rescue_from "Bad Request", with: :status_400

  def status_500
    render json: { error: "Internal Server Error" }, status: 500
  end

  def status_400
    render json: { error: "Bad Request: please enter valid parameters"}, status: 400
  end
end
