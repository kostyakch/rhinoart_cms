class AddAvatarToUsers < ActiveRecord::Migration
  def change
  	add_column :rhinoart_users, :avatar, :string
  end
end
