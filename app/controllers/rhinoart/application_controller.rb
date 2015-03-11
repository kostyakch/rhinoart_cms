# encoding: utf-8
module Rhinoart
	class ApplicationController < ActionController::Base
		include ViewHelpers::SessionHelper

		before_action :set_locale
		before_filter :configure_permitted_parameters, if: :devise_controller?
		before_filter :set_current_user

		#before_filter :check_uri if Rails.configuration.redirect_to_www

		def set_locale
			if current_user.present? && current_user.locales.present? && current_user.locales.count == 1
				I18n.locale = params[:locale] || current_user.locales.first || I18n.default_locale
			else
				I18n.locale = params[:locale] || I18n.default_locale
			end
		end	


		# Force signout to prevent CSRF attacks
		def handle_unverified_request
			sign_out
			super
		end

		def check_uri
			redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
		end


		def default_url_options(options={})
			if I18n.locale != I18n.default_locale
				{ locale: I18n.locale }
			else
				{ locale: nil }
			end
		end	

		def set_current_user
			User.current = current_user
    end

		private     

			def correct_user
				if params[:id]
					@user = User.find(params[:id])
					redirect_to(root_path) unless current_user?(@user)   
				end
			end

		protected
			def configure_permitted_parameters
				# params.require(:post).permit(:title, :text)
				devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email, :admin_role) }
				# devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:password, :password_confirmation, :email, :name) }
			end  			
	end
end
