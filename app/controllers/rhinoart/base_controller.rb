# encoding: utf-8
module Rhinoart
	class BaseController < ApplicationController
		include SessionsHelper
		before_filter :check_if_user_has_admin_role
		

		rescue_from CanCan::AccessDenied do |exception|
			if user_signed_in? && current_user.approved? && current_user.admin?
				flash.now[:info] = current_user.approved? ? "Access denied." : "Access denied: You need to be approved first."
				render :template => 'rhinoart/shared/no_approved', :status => 403
			else
				redirect_to new_user_session_path, alert: exception.message
			end
		end


		private    
			def check_if_user_has_admin_role
				authorize! :access, :admin_panel
			end


	end
end
