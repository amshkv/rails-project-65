# frozen_string_literal: true

class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.under_moderation.order(id: :desc).page(params[:page])
  end
end
