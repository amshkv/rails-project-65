# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @search = Bulletin.order(id: :desc).ransack(params[:q])
    @bulletins = @search.result.page(params[:page])
    @categories = Category.all
    # TODO: на хекслете у нас есть отдельный метод в хелпере для этого дела, может тут тоже бахнуть?
    @states = Bulletin.aasm.states.map { |state| [state.human_name, state.name] }
  end

  def publish
    bulletin = resource_bulletin

    if bulletin.may_publish?
      bulletin.publish!
      redirect_back fallback_location: admin_bulletins_path, notice: t('bulletin.publish.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('bulletin.publish.failure')
    end
  end

  def reject
    bulletin = resource_bulletin

    if bulletin.may_reject?
      bulletin.reject!
      redirect_back fallback_location: admin_bulletins_path, notice: t('bulletin.reject.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('bulletin.reject.failure')
    end
  end

  def archive
    bulletin = resource_bulletin

    if bulletin.archive!
      redirect_back fallback_location: admin_bulletins_path, notice: t('bulletin.archive.success')
    else
      redirect_back fallback_location: admin_bulletins_path, alert: t('bulletin.archive.failure')
    end
  end

  private

  def resource_bulletin
    @resource_bulletin ||= Bulletin.find(params[:id])
  end
end
