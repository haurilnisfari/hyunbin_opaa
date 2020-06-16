class AccountsController < ApplicationController
  helper_method :current_user
  before_action :require_login

  def new
    @account = Account.new
  end

  def create
    account = Account.new(resource_params)
    account.save
    current_user.account_id = account.id
    current_user.save

    redirect_to expenses_path, notice: "Successfully Created an Account"
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
    puts "nnnn"
    params.require(:account).permit(:name)
  end

end
