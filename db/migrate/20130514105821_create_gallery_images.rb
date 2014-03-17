class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :rhinoart_gallery_images do |t|
      t.integer :gallery_id
      t.foreign_key :rhinoart_galleries, column: 'gallery_id', options: 'ON DELETE CASCADE'

      t.string :path, :limit  => 150
      t.text :annotation
      t.boolean :main,  :default => false, :null => false
      t.boolean :active, :default => true, :null => false
      t.integer :position, :null => false

      t.timestamps
    end
    add_index :rhinoart_gallery_images, [:gallery_id, :path], :unique => true

  end
end
