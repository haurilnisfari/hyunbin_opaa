class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(resource_params)

    if @user.save
      flash[:notice] = "User has been created"
      redirect_to login_path
    else
      render "new"
    end
  end

  private

  def resource_params
    params.require(:user).permit(:name, :username, :email, :bio, :password,:password_confirmation, :account_id)
  end

end
