# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized, only: %i[new create to_moderate archive]

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
    @categories = Category.all
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
    @categories = Category.all
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(permitted_params)

    if @bulletin.save
      redirect_to @bulletin, notice: I18n.t('bulletin.create.success')
    else
      render :new, status: :unprocessable_entity, alert: I18n.t('bulletin.create.failure')
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(permitted_params)
      redirect_to @bulletin, notice: I18n.t('bulletin.update.success')
    else
      render :edit, status: :unprocessable_entity, alert: I18n.t('bulletin.update.failure')
    end
  end

  def to_moderate
    bulletin = Bulletin.find(params[:id])
    authorize bulletin

    if bulletin.send_to_moderate!
      redirect_to profile_path, notice: I18n.t('bulletin.to_moderate.success')
    else
      redirect_to profile_path, alert: I18n.t('bulletin.to_moderate.failure')
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    authorize bulletin

    if bulletin.archive!
      redirect_to profile_path, notice: I18n.t('bulletin.archive.success')
    else
      redirect_to profile_path, alert: I18n.t('bulletin.archive.failure')
    end
  end

  private

  def permitted_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
