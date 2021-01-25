class BudgetsController < ApplicationController
    helper_method :sort_column, :sort_direction, :current_user, :account_name
    before_action :require_login

    def new
        if current_user && current_user[:account_id]
          @budget = Budget.new
          @categories = Category.all
          3.times { @budget.budget_categories.build }
          # @budget.budget_categories.build
        else
          redirect_to new_account_path, notice: "You don't have an Account, Please Create an Account!"
        end
      end
    
      def create
        @budget = Budget.new(resource_params)
        @budget.save
        redirect_to budgets_path
      end

    def index
        @budgets = Budget.all.order(sort_column + " " + sort_direction)
        @categories = Category.all
        @expenses = Expense.all
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
      params.require(:budget).permit(:id, :name, :period, budget_categories_attributes:[:category_id, :amount])
    end

    def sort_column
      Budget.column_names.include?(params[:sort]) ? params[:sort] : "period"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

  
  end
  