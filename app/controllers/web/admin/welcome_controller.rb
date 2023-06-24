# frozen_string_literal: true

class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.all.order(created_at: :desc)
  end
end
