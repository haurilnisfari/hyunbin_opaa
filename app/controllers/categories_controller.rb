class CategoriesController < ApplicationController
  before_action :require_login
  
  def new
    if current_user && current_user[:account_id]
      @category = Category.new
      @category.parent_category = Category.find(params[:id]) unless params[:id].nil?
      all = Category.all
      @categories = all.where(parent_id=nil)
    else
      redirect_to new_account_path, notice: "You don't have an Account, Please Create an Account!"
    end
  end

  def create
    category = Category.new(resource_params)
    category.save
    redirect_to categories_path
  end

  def index
    @category = nil
    all = Category.all
    @categories = all.where(parent_id:nil).page(params[:page])
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    #jika ada category lain yg punya parent_id == id nya dia, maka dikatakan dia punya subcategory
    #maka di looping
    id = @category.id
    @subcategory = @categories.where(parent_id:id)
    
  end

  def edit
    @category = Category.find(params[:id])
    all = Category.all
    @categories = all.where(parent_id=nil)
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
    params.require(:category).permit(:name, :parent_id)
  end

end
