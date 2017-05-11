class RemovePasswordDigestFromUsers < ActiveRecord::Migration
  def change
    remove_column :rhinoart_users, :password_digest
  end
end
