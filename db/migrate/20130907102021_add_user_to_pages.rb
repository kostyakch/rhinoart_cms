class AddUserToPages < ActiveRecord::Migration
  def change
    change_table :rhinoart_pages do |t|
      t.integer :user_id      
    end   	
    add_index :rhinoart_pages, :user_id
  end
end
