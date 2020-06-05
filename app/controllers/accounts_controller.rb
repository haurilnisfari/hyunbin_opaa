class AccountsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    account = Account.new(resource_params)
    account.save

    redirect_to accounts_path
  end

  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    account = Account.find(params[:id])
    account.update(resource_params)
    redirect_to account_path(account)
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end

  private

  def resource_params
    params.require(:account).permit(:name)
  end

end
