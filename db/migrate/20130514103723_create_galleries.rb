class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :rhinoart_galleries do |t|
      t.integer :page_id
      t.foreign_key :rhinoart_pages, column: 'page_id', options: 'ON DELETE CASCADE'
    	
      t.string :url, :limit  => 150, :null => true
      t.string :name, :limit  => 255, :null => false
      t.text :descr
      t.boolean :active, :default => true
      t.integer :position, :null => false

      t.timestamps
    end
    add_index :rhinoart_galleries, :url, :unique => true
    add_index :rhinoart_galleries, :name, :unique => true

  end
end