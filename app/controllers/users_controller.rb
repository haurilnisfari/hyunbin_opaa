class UsersController < ApplicationController
  layout false

  def new
    @user = User.new
  end

  def create
    @user = User.new(resource_params)

    if @user.save
      flash[:notice] = "User has been created, Please Login :)"
      redirect_to login_path
    else
      render "new"
    end
  end

  def index
    @users = User.all
  end

  private

  def resource_params
    params.require(:user).permit(:name, :username, :email, :bio, :password,:password_confirmation, :account_id)
  end

end
