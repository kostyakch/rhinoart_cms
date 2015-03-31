class PageComment < ActiveRecord::Migration
  def change
    create_table :rhinoart_page_comments do |t|
      t.integer :user_id
      # t.foreign_key :rhinoart_users, column: 'user_id', options: 'ON DELETE CASCADE'

      t.integer :page_id
      # t.foreign_key :rhinoart_pages, column: 'page_id'

      t.integer :parent_id
      # t.foreign_key :rhinoart_page_comments, column: 'parent_id', options: 'ON DELETE CASCADE'

      t.text :comment, :null => false
      t.boolean :approved, :default => false

      t.timestamps
    end
    add_index :rhinoart_page_comments, :user_id
    add_index :rhinoart_page_comments, :page_id
    add_index :rhinoart_page_comments, :parent_id
  end
end
