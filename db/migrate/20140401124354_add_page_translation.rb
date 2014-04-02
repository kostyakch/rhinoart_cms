class AddPageTranslation < ActiveRecord::Migration
  def self.up
    Rhinoart::Page.create_translation_table!({
      :name => :string,
      :active => :string,
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Rhinoart::Page.drop_translation_table! :migrate_data => true
  end
end
