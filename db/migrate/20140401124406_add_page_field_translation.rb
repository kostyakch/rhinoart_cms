class AddPageFieldTranslation < ActiveRecord::Migration
  def self.up
    Rhinoart::PageContent.create_translation_table!({
      :name => :string,
      :content => :text,
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Rhinoart::PageContent.drop_translation_table! :migrate_data => true
  end
end
