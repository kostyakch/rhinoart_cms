require_dependency "rhinoart/application_controller"

module Rhinoart
	class StructuresController < PagesController
		before_filter { access_only_roles %w[ROLE_ADMIN] }	

		def showhide
			page = Page.find(params[:id])
			page.update_attributes( :active => !page.active? )

			redirect_to structures_path
		end			
	end
end
