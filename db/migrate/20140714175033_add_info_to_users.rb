class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :rhinoart_users, :info, :text
  end
end
