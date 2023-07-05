# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @bulletins = current_user.bulletins.order(id: :desc).page(params[:page])
  end
end
