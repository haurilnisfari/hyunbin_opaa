class AddAmountToBudgetCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_categories, :amount, :integer
  end
end
