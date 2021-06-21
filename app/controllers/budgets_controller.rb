class BudgetsController < ApplicationController
    helper_method :sort_column, :sort_direction, :current_user, :account_name
    before_action :require_login

    def new
        if current_user && current_user[:account_id]
          @budget = Budget.new
          @categories = Category.where(parent_id:nil)
          @budget_categories = BudgetCategory.all
          # 3.times { @budget.budget_categories.build }
          # @budget.budget_categories.build
        else
          redirect_to new_account_path, notice: "You don't have an Account, Please Create an Account!"
        end
      end
    
      def create
        category_ids = params[:category_ids]
        amounts = params[:amounts]
        category_map_amount = []

        category_ids.each_with_index do |cat_id, index|
          hash = {
            category_id: cat_id,
            amount: amounts[index]
          }

          category_map_amount << hash

        end

        budget = Budget.new(resource_params)
        budget.save

        category_map_amount.each do |cat_amount|
          budget_category = BudgetCategory.new
          budget_category.budget_id = budget.id
          budget_category.category_id = cat_amount[:category_id]
          if cat_amount[:amount].present?
            budget_category.amount = cat_amount[:amount]
          else
            budget_category.amount = 0
          end
          budget_category.save
        end

        redirect_to budgets_path
      end

    def index
        @budgets = Budget.all.order(sort_column + " " + sort_direction)
        @categories = Category.where(parent_id:nil)
        @expenses = Expense.all
        @budget_categories = BudgetCategory.all
    end

  
    def show
      @budget = Budget.find(params[:id])
      @expenses = Expense.all
      @bcs = @budget.budget_categories


    end
  
    def edit
      @budget = Budget.find(params[:id])
    end
  
    def update
      @budget = Budget.find(params[:id])
      if @budget.update_attributes(params[:budget])
        flash[:notice] = "Successfully updated Budget."
        redirect_to @budget
      else
        render :action  => 'edit'
      end
    end
  
    def destroy
      @budget = Budget.find(params[:id])
      @budget.destroy
      redirect_to budgets_path
    end
  
    private
  
    def resource_params
      params.require(:budget).permit(:id, :name, :period)
    end

    def sort_column
      Budget.column_names.include?(params[:sort]) ? params[:sort] : "period"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def total_sum_expense_budgeting
      total_budgeting = BudgetCategory.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).sum(:amount)
    end
    helper_method :total_sum_expense_budgeting

    def sum_this_month_expense(category)
      category = category.get_id_and_child_ids
      this_month = Expense.where(date: Date.today.beginning_of_month..Date.today.end_of_month, category_id: category ).sum(:amount)
    end
    helper_method :sum_this_month_expense

    def total_sum_this_month_expense
      this_month = Expense.where(date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:amount)
    end
    helper_method :total_sum_this_month_expense

    def sum_last_month_expense(category)
      category = category.get_id_and_child_ids
      last_month = Expense.where(date: Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month, category_id: category ).sum(:amount)
    end
    helper_method :sum_last_month_expense

    def total_sum_last_month_expense
      last_month = Expense.where(date: Date.today.last_month.beginning_of_month..Date.today.last_month.end_of_month).sum(:amount)
    end
    helper_method :total_sum_last_month_expense

   

  end
  