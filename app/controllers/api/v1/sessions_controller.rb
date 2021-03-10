class Api::V1::SessionsController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    binding.pry
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Bad Request: Sorry, your credentials are bad"}, status: 400
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
