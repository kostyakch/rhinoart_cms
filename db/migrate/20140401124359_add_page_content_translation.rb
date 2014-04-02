class AddPageContentTranslation < ActiveRecord::Migration
  def self.up
    Rhinoart::PageField.create_translation_table!({
      :value => :string,
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Rhinoart::PageField.drop_translation_table! :migrate_data => true
  end
end
