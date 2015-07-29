class AddOmniAuthColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :rhinoart_users, :provider, :string
    add_column :rhinoart_users, :uid, :string
  end
end
