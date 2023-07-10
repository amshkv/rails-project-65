# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all.order(id: :asc).page(params[:page])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(permitted_params)

    if @category.save
      redirect_to admin_categories_path, notice: I18n.t('category.create.success')
    else
      flash.now[:alert] = I18n.t('category.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(permitted_params)
      redirect_to admin_categories_path, notice: I18n.t('category.update.success')
    else
      flash.now[:alert] = I18n.t('category.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    category = Category.find(params[:id])

    # TODO: можно вынести общее отдельно, а в теле условия оставить только флешки и действия
    if category.bulletins.any?
      redirect_to admin_categories_path, warning: I18n.t('category.destroy.not_empty')
    else
      category.destroy
      redirect_to admin_categories_path, notice: I18n.t('category.destroy.success')
    end
  end

  private

  def permitted_params
    params.require(:category).permit(:name)
  end
end
