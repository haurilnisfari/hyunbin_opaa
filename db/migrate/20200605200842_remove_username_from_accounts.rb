class RemoveUsernameFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :username, :string
  end
end
