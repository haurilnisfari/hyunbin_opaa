class AddTimestampsToBudgetCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :budget_categories, :created_at, :datetime
    add_column :budget_categories, :updated_at, :datetime
  end
end
