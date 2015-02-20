require_dependency "rhinoart/application_controller"

module Rhinoart
	class DashboardController < BaseController		
		layout 'layouts/rhinoart/application'
		# before_filter :signed_in_user
		# before_filter { access_only_roles %w[ROLE_ADMIN ROLE_EDITOR ROLE_SALLER] }	

		def index
			# User activity
			if can?(:manage, :all)
				@users = Rhinoart::User.joins('LEFT JOIN versions ON versions.whodunnit = rhinoart_users.id ').where('versions.created_at > ?', 1.week.ago).group('rhinoart_users.id').order('versions.created_at').paginate(:page => params[:page], :per_page => 5)
			else
				@users = Rhinoart::User.joins('LEFT JOIN versions ON versions.whodunnit = rhinoart_users.id ').where('rhinoart_users.id = ? and versions.created_at > ?', current_user, 1.week.ago).group('rhinoart_users.id').paginate(:page => params[:page], :per_page => 1)
			end		
		end
	end
end
