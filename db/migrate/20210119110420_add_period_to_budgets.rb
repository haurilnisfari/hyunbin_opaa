class AddPeriodToBudgets < ActiveRecord::Migration[6.0]
  def change
    add_column :budgets, :period, :date
  end
end
