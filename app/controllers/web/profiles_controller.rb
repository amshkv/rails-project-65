# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @search = current_user.bulletins.order(id: :desc).ransack(params[:q])
    @bulletins = @search.result.page(params[:page])
    @categories = Category.all
    @states = Bulletin.aasm.states.map { |state| [state.human_name, state.name] }
  end
end
