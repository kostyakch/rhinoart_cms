class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	before_filter :check_uri

	def check_uri
		if Rails.configuration.redirect_to_www
			redirect_to request.protocol + "www." + request.host_with_port + request.fullpath if !/^www/.match(request.host)
		end
	end
end
