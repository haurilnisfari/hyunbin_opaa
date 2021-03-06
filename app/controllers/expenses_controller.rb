class ExpensesController < ApplicationController
  helper_method :sort_column, :sort_direction, :current_user, :account_name
  before_action :require_login

  def new
    if current_user && current_user[:account_id]
      @expense = Expense.new
      @categories = Category.all
    else
      redirect_to new_account_path, notice: "You don't have an Account, Please Create an Account!"
    end
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
      @expenses = Expense.based_account_id(current_user[:account_id]).order(sort_column + " " + sort_direction).page(params[:page])
      if current_user && current_user[:account_id] && params[:expense] && params[:expense][:category_id].present?
        @expenses = Expense.based_account_id(current_user[:account_id]).filter_by_category(params[:expense][:category_id]).page(params[:page])
      end
    else
      redirect_to new_account_path, notice: "You don't have an Account, Please Create an Account!"
    end

    respond_to do |format|
      format.html
      format.csv {send_data @expenses.to_csv, filename: "expense-#{Date.today}.csv"}
    end
  end

  # def import
  #   @import = Expense::Import.new expense_import_params
  #   if @import.save
  #     redirect_to expenses_path, notice: "Imported #{@import.imported_count} expenses"
  #   else
  #     @expenses = Expense.all
  #     flash[:alert] = "There were #{"@import.errors.count"} errors with your CSV file"
  #     render action: :index
  #   end
  # end

  def import
    Expense.import(params[:file])
    redirect_to root_url, notice: "Expense imported"
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

  # def expense_import_params
  #   params.require(:expense_import).permit(:file)
  # end
end
