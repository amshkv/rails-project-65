# frozen_string_literal: true

class Web::Admin::UsersController < Web::Admin::ApplicationController
  def index
    @users = User.all.order(id: :desc).page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(permitted_params)
      redirect_to admin_users_path, notice: t('user.update.success')
    else
      flash.now[:alert] = t('user.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:admin)
  end
end
