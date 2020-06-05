class RemoveBioFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :bio, :text
  end
end
