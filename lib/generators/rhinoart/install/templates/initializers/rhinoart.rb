class RhinoartConfig < Rails::Railtie
	config.frontend_roles = ['User', 'Subscriber', 'Blogger']
	config.order_in_list = :by_date # or :by_position

end

Rhinoart.setup do |config|
	config.devise_controllers = {
		sessions: 'rhinoart/sessions',
		passwords: 'rhinoart/passwords',
		# omniauth_callbacks: 'rhinoart/omniauth_callbacks' # Google authentication
	}

	config.devise_routes = {
		class_name: 'Rhinoart::User',
		module: :devise,
		controllers: Rhinoart.devise_controllers
	}

	config.devise_scopes = [
		:database_authenticatable, 
		:recoverable, 
		:registerable, 
		:trackable, 
		:validatable,
		# :omniauthable, # Google authentication
		# :omniauth_providers => [:google_oauth2] # Google authentication
	]

end
