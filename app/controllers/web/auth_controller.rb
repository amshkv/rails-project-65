# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    email = auth.info.email
    name = auth.info.name

    user = User.find_or_create_by(email:, name:) # TODO: что делать, если юзер сменит что-то из этого?

    if user.save!
      sign_in(user)
      redirect_to root_path, notice: I18n.t('login.success')
    else
      redirect_to root_path, alert: I18n.t('login.failure')
    end
  end

  def logout
    sign_out
    redirect_to root_path, notice: I18n.t('logout.success')
  end
end
