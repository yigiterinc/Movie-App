class AuthenticateController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      @user = User.find_by_email(params[:email])
      render json: { user: @user, auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end