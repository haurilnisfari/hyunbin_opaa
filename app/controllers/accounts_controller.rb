class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(resource_params)
    if @account.save
      flash[:notice] = "Account has been created"
      # redirect_to login_path
      redirect_to expenses_path
    else
      render "new"
    end
  end

  private

  def resource_params
    params.require(:account).permit(:name, :username, :email, :bio, :password,:password_confirmation)
  end

end
