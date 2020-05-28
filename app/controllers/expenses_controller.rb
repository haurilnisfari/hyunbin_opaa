class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
    @categories = Category.all
  end

  def create
    flash[:notice] = "Expense has been created"
    expense = Expense.new(resource_params)
    expense.save

    redirect_to expenses_path
  end

  def index
    if params[:expense] && params[:expense][:category_id].present?
      @expenses = Expense.filter_by_category(params[:expense][:category_id])
    else
      @expenses = Expense.all
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
    redirect_to expense_path(expense)
  end

  def destroy
    flash[:notice] = "Expense has been deleted"
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to expenses_path
  end

  private

  def resource_params
    params.require(:expense).permit(:name, :amount, :date, :category_id)
  end

end
