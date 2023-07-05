# frozen_string_literal: true

class Web::WelcomeController < Web::ApplicationController
  def index
    @bulletins = Bulletin.published.includes(image_attachment: :blob).order(id: :desc).page(params[:page])
  end
end
