class AddGalleryTranslation < ActiveRecord::Migration
  def self.up
    Rhinoart::Gallery.create_translation_table!({
      :name => :string,
      :descr => :text, 
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Rhinoart::Gallery.drop_translation_table! :migrate_data => true
  end
end
