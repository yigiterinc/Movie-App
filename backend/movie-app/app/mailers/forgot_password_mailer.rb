class ForgotPasswordMailer < ApplicationMailer
  def forgot_password_email(user, token)
      @user = user
      mail(to: @user.email, subject: 'Reset Password')
  end
end
