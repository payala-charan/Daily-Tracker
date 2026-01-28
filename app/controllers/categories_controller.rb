class CategoriesController < ApplicationController
  before_action :require_login
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = current_user.categories.order(:name)
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category created successfully"
    else
      @categories = current_user.categories.order(:name)
      render :index
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category deleted successfully"
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
