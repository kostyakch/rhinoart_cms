require_dependency "rhinoart/application_controller"

module Rhinoart
	class SessionsController < ApplicationController
		layout 'layouts/rhinoart/non_autorize' #layouts/rhinoart/header

		def new
		end

		def create
			user = User.find_by_email(params[:session][:email].downcase)
			if user && user.authenticate(params[:session][:password])
			  sign_in user
			  redirect_back_or root_path
			else
			  flash.now[:error] = t('_ERROR_AUTHENTICATE')
			    render 'new'
			end
		end
		
		def destroy
			sign_out
	    	redirect_to main_app.root_path
		end

		def signed_user
		    respond_to do |format|
				format.html { render 'new' }
				format.js { }
		    end		
		end

		private
			def has_role?(roles=[])
				roles.include? AmendiaRemote.config.access_role
			end
	end
end

