class ChangeSettingsValue < ActiveRecord::Migration
	def change
		remove_index :rhinoart_settings, [:name, :value]
		change_column :rhinoart_settings, :value, :text, :null => true

		add_index :rhinoart_settings, :name, :unique => true 
	end
end
