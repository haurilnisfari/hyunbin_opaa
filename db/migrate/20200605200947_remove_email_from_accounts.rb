class RemoveEmailFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :email, :string
  end
end
