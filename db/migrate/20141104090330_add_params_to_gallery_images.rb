class AddParamsToGalleryImages < ActiveRecord::Migration
	def change
		add_column :rhinoart_gallery_images, :params, :text
	end
end
