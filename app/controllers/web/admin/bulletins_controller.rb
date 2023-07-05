# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @search = Bulletin.order(id: :desc).ransack(params[:q])
    @bulletins = @search.result.page(params[:page])
    @categories = Category.all
    @states = Bulletin.aasm.states.map(&:name)
  end

  def publish
    bulletin = Bulletin.find(params[:id])

    if bulletin.publish!
      redirect_to admin_bulletins_path, notice: t('bulletin.publish.success')
    else
      redirect_to admin_bulletins_path, alert: t('bulletin.publish.failure')
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])

    if bulletin.reject!
      redirect_to admin_bulletins_path, notice: t('bulletin.reject.success')
    else
      redirect_to admin_bulletins_path, alert: t('bulletin.reject.failure')
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])

    if bulletin.archive!
      redirect_to admin_bulletins_path, notice: t('bulletin.archive.success')
    else
      redirect_to admin_bulletins_path, alert: t('bulletin.archive.failure')
    end
  end
end
