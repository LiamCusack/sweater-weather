class Api::V1::SessionsController < ApplicationController
  before_action :block_url_params, only: [:login]

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UsersSerializer.new(user)
    else
      render json: { error: "Bad Request: Sorry, your credentials are bad"}, status: 400
    end
  end
end
