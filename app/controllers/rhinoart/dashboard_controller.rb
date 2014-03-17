require_dependency "rhinoart/application_controller"

module Rhinoart
	class DashboardController < ApplicationController
		# before_filter :signed_in_user
		# before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR ROLE_SALLER] }	

		def index
			store_location
			@orders = Order.where('status = ?', 'new').limit(20)
		end
	end
end
