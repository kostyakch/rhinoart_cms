# encoding: utf-8
module Rhinoart
	class BaseController < Rhinoart::ApplicationController
		before_filter :check_if_user_has_admin_role		

		rescue_from CanCan::AccessDenied, :with => :access_denied_handler

		private
			def access_denied_handler(exception)
				if user_signed_in?
					if !can? :access, :admin_panel
					redirect_to main_app.root_path, alert: exception.message
					else
						flash.now[:info] = "Access denied."
						render :template => 'rhinoart/shared/no_approved', :status => 403
					end
				else
					redirect_to rhinoart.new_user_session_path(redirect_to: request.fullpath), alert: exception.message
				end
			end

			def check_if_user_has_admin_role
				authorize! :access, :admin_panel
			end
	end
end
