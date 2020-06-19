class ExpensesController < ApplicationController
  helper_method :sort_column, :sort_direction, :current_user, :account_name
  before_action :require_login

  def new
    @expense = Expense.new
    @categories = Category.all
  end

  def create
    flash[:notice] = "Expense has been created"
    expense = Expense.new(resource_params)
    expense.save
    expense.account_id = current_user.account_id
    expense.save

    redirect_to expenses_path
  end

  def index
    if current_user && current_user[:account_id]
      @expenses = Expense.based_account_id(current_user[:account_id]).order(sort_column + " " + sort_direction)
      if current_user && current_user[:account_id] && params[:expense] && params[:expense][:category_id].present?
        @expenses = Expense.based_account_id(current_user[:account_id]).filter_by_category(params[:expense][:category_id])
      end
    else
      redirect_to new_account_path, notice: "You haven't an Account, Please Create an Account!"
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def edit
    @expense = Expense.find(params[:id])
    @categories = Category.all
  end

  #when we run edit method then we update the database by update method
  def update
    # render plain: params.inspect #to inspect what kind of params that be return value of this method
    flash[:notice] = "Expense has been updated"
    expense = Expense.find(params[:id]) #catch the expense which has the active id
    expense.update(resource_params)
    redirect_to expenses_path
  end

  def destroy
    flash[:notice] = "Expense has been deleted"
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path
  end

  private

  def resource_params
    params.require(:expense).permit(:name, :amount, :date, :category_id, :account_id)
  end

  def sort_column
    Expense.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def account_name
    account_id = current_user.account_id
    Account.where(id: account_id).pluck(:name).join(" ")
  end

end
