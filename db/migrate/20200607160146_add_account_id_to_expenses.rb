class AddAccountIdToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :account_id, :integer
  end
end
