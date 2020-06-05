class RemovePasswordDigestFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :password_digest, :string
  end
end
