class CreateRhinoTables < ActiveRecord::Migration
  def self.up
    create_table :rhinoart_settings do |t|
      t.string :name, :limit  => 120, :default => "", :null => false
      t.string :value, :limit => 255, :default => "", :null => false
    end
    add_index :rhinoart_settings, [:name, :value], :unique => true 

    create_table :rhinoart_pages do |t|
      t.references :parent, index: true
      # t.foreign_key :rhinoart_pages, column: 'parent_id', options: 'ON DELETE CASCADE'

      t.string :name, :null => false
      t.string :slug, :null => false
      t.integer :position, :null => false
      t.integer :menu, :default => true
      t.boolean :active, :default => true
      t.string  :ptype,  :limit => 20, :default => "page", :null => false
      t.string  :sm_p,  :limit => 7, :default => "weekly", :null => false
      t.decimal :st_pr, :precision => 10, :scale => 2, :default => 0.5, :null => false

      t.timestamps
    end
    add_index :rhinoart_pages, [:parent_id, :slug], :unique => true    


    create_table :rhinoart_page_contents, :force => true do |t|
      t.integer :page_id
      # t.foreign_key :rhinoart_pages, column: 'page_id', options: 'ON DELETE CASCADE'

      t.string :name, :limit => 100, :null => false
      t.text :content
      t.integer :position, :null => false
    end
    add_index :rhinoart_page_contents, :page_id
    add_index :rhinoart_page_contents, :name
    add_index :rhinoart_page_contents, [:page_id, :name], :unique => true


    create_table :rhinoart_page_fields do |t|
      t.integer :page_id, :null => false
      # t.foreign_key :rhinoart_pages, column: 'page_id', options: 'ON DELETE CASCADE'

      t.string :name, :limit  => 120, :null => false
      t.text :value
      t.string :ftype, :limit => 60
      t.integer :position, :null => false
    end
    add_index :rhinoart_page_fields, :page_id
    add_index :rhinoart_page_fields, [:page_id, :name], :unique => true, name: 'page_fields_page_id_and_name'


    create_table :rhinoart_users do |t|
      t.string :name, :limit => 250 #, :null => false
      t.string :email, :limit => 100 , :null => false
      t.boolean :active, :default => true, :null => false
      t.string :roles, :default => "ROLE_USER", :null => false
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :rhinoart_users, :email, unique: true
    add_index  :rhinoart_users, :remember_token      

  end  

  def self.down    
    drop_table "page_contents"
    drop_table "page_fields"
    drop_table "pages"
    drop_table "users"
    drop_table "config"
  end
end
