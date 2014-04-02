class AddGalleryImageTranslation < ActiveRecord::Migration
  def self.up
    Rhinoart::GalleryImage.create_translation_table!({
      :annotation => :text,
      :path => :string,
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Rhinoart::GalleryImage.drop_translation_table! :migrate_data => true
  end
end
