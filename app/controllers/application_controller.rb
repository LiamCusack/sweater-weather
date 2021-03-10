class ApplicationController < ActionController::API
  rescue_from "Bad Request", with: :status_400
  rescue_from ActiveRecord::RecordInvalid, with: :passwords_dont_match

  def passwords_dont_match
    render json: {error: "Bad Request: passwords do not match"}, status: 400
  end

  def status_500
    render json: { error: "Internal Server Error" }, status: 500
  end

  def status_400
    render json: { error: "Bad Request: please enter valid parameters"}, status: 400
  end
end
