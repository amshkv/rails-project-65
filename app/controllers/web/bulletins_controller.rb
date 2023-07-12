# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized, only: %i[show new edit create update to_moderate archive]

  def index
    @search = Bulletin.published.includes(image_attachment: :blob).order(id: :desc).ransack(params[:q])
    @bulletins = @search.result.page(params[:page])
    @categories = Category.all
  end

  def show
    @bulletin = resource_bulletin
    authorize @bulletin
  end

  def new
    authorize Bulletin
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = resource_bulletin
    authorize @bulletin
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(permitted_params)

    if @bulletin.save
      redirect_to @bulletin, notice: I18n.t('bulletin.create.success')
    else
      flash.now[:alert] = I18n.t('bulletin.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = resource_bulletin
    authorize @bulletin

    if @bulletin.update(permitted_params)
      redirect_to @bulletin, notice: I18n.t('bulletin.update.success')
    else
      flash.now[:alert] = I18n.t('bulletin.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    bulletin = resource_bulletin
    authorize bulletin

    if bulletin.may_send_to_moderate?
      bulletin.send_to_moderate!
      redirect_to profile_path, notice: I18n.t('bulletin.to_moderate.success')
    else
      redirect_to profile_path, alert: I18n.t('bulletin.to_moderate.failure')
    end
  end

  def archive
    bulletin = resource_bulletin
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

  def resource_bulletin
    Bulletin.find(params[:id])
  end
end
