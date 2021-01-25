class AddTimestampsToBudgets < ActiveRecord::Migration[6.0]
  def change
    add_column :budgets, :created_at, :datetime
    add_column :budgets, :updated_at, :datetime
  end
end
