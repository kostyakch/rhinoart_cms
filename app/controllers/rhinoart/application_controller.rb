# encoding: utf-8
module Rhinoart
	class ApplicationController < ActionController::Base
		include SessionsHelper
		before_filter :signed_in_user

		before_filter :check_uri if Rails.configuration.redirect_to_www

		# def set_locale
		#   I18n.locale = params[:locale] || I18n.default_locale
		# end  


		# Force signout to prevent CSRF attacks
		def handle_unverified_request
			sign_out
			super
		end

		def check_uri
			redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
		end


		private    
			def signed_in_user
				unless signed_in?
					store_location

					flash[:error] = t('_SIGN_IN')
					redirect_to login_url
				end
			end   

			def correct_user
				if params[:id]
					@user = User.find(params[:id])
					redirect_to(root_path) unless current_user?(@user)   
				end
			end

			def admin_only      
				unless signed_in? && has_role?('ROLE_ADMIN')
					store_location
					redirect_to login_url
				end       
			end  

			def access_only_roles(roles)
				access = false
				roles.each do |r| 
					access = has_role?( r )
					break if access
				end

				if not access
					store_location        


					if current_user.roles.split(',').include? 'ROLE_EDITOR' 
					  render :template => 'site/err_403', :status => 403
					else
					  flash[:error] = t('No permissions to perform this operation.')
					  redirect_to login_url
					end
				end
			end 
	end
end
