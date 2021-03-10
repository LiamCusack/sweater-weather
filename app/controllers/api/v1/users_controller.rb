class Api::V1::UsersController < ApplicationController
  before_action :block_url_params, only: [:create]
  
  def create
      user = User.new(user_params)
      if user.save
        render json: UsersSerializer.new(user), status: 201
      else
        self.status_400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
