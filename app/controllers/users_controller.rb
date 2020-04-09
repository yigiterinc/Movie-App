class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @users = User.all

    render json: @users, status: :ok
  end

  def create
    @user = User.new(user_params)

    @user.save
    render json: @user, status: :created
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
