module Rhinoart
	class SessionsController < Devise::SessionsController
		protect_from_forgery

		protected

			def after_sign_in_path_for(resource)
				if params[:redirect_to].present? || can?(:access, :admin_panel)
					params[:redirect_to] || root_path
				else
					main_app.root_path
				end				
			end

			def after_sign_out_path_for(resource)
				if params[:redirect_to].present?
					params[:redirect_to] 
				else
					main_app.root_path
				end				
			end		
	end
end