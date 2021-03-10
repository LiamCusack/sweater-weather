class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
