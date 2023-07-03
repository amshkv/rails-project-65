# frozen_string_literal: true

class Web::WelcomeController < Web::ApplicationController
  def index
    @bulletins = Bulletin.published.includes(image_attachment: :blob).order(created_at: :desc)
  end
end
