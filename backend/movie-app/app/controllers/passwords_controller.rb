class PasswordsController < ApplicationController
  skip_before_action :authenticate_request, raise: false

  def forgot  # params: email
    if params[:email].blank?
      return render json: { error: 'Email not present' }
    end # is email present?
    
    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      ForgotPasswordMailer.forgot_password_email(user).deliver_now
      # SEND EMAIL WITH TOKEN
    else
      render json: { error: [
          'Email address not found. Please check and try again'
      ] }, status: :not_found
    end
  end

  def reset # params: token, password
    token = params[:token].to_s

    return render json: { error: 'Token not present' } if params[:token].blank?

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: { status: 'ok' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Link not valid or expired. Try generating a new link.' }, status: :not_found
    end
  end
end

