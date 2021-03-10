class ApplicationController < ActionController::API
  rescue_from "Bad Request", with: :status_400
  rescue_from ActiveRecord::RecordInvalid, with: :status_400

  def status_400
    if params[:password] == ""
      render json: {error: "Bad Request: password cannot be blank"}, status: 400
    elsif params[:password] != params[:password_confirmation]
      render json: {error: "Bad Request: passwords do not match"}, status: 400
    elsif params[:email] == ""
      render json: {error: "Bad Request: email cannot be blank"}, status: 400
    else
      render json: {error: "Bad Request: email is already taken"}, status: 400
    end
  end

  def status_500
    render json: { error: "Internal Server Error" }, status: 500
  end
end
