class CategoriesController < ApplicationController
  before_action :require_login

  def new
    @category = Category.new
  end

  def create
    category = Category.new(resource_params)
    category.save

    redirect_to categories_path
  end

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    category.update(resource_params)
    redirect_to categories_path
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  private

  def resource_params
    params.require(:category).permit(:name)
  end

end
