class AddDescriptionToSettings < ActiveRecord::Migration[5.1]
  def change
    change_table :rhinoart_settings do |t|
      t.text :descr, null: true
    end
  end
end
