# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    email = auth.info.email

    user = User.find_or_create_by(email:)

    if user.save!
      session[:user_id] = user.id
      redirect_to root_path, notice: I18n.t('login.success')
    else
      redirect_to root_path, alert: I18n.t('login.failure')
    end
  end

  def logout
    reset_session
    redirect_to root_path, notice: I18n.t('logout.success')
  end
end
