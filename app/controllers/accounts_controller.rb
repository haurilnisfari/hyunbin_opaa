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
    @accounts = Account.where(id: current_user.account_id)
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
    current_user.account_id = nil
    current_user.save
    @account = Account.find(params[:id])
    @account.destroy
    expenses = Expense.where(account_id: (params[:id]))
    expenses.each do |expense|
      expense.destroy
    end
    redirect_to accounts_path
  end

  private

  def resource_params
    params.require(:account).permit(:name)
  end

end
