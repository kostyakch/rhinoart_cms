module Rhinoart
	class PasswordsController < Devise::PasswordsController
		protect_from_forgery

		protected

			# def after_sign_in_path_for(resource)
			# 	if params[:redirect_to].present? || can?(:access, :admin_panel)
			# 		params[:redirect_to] || root_path
			# 	else
			# 		main_app.root_path
			# 	end				
			# end		
	end
end