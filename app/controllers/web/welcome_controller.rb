# frozen_string_literal: true

class Web::WelcomeController < Web::ApplicationController
  def index
    @search = Bulletin.published.includes(image_attachment: :blob).order(id: :desc).ransack(params[:q])
    @bulletins = @search.result.page(params[:page])
    @categories = Category.all
  end
end
