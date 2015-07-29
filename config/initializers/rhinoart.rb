class RhinoartConfig < Rails::Railtie
	# config.app_generators.frontend_roles = ['User', 'Subscriber', 'Blogger']
	config.frontend_roles = ['User', 'Subscriber', 'Blogger']
	config.order_in_list = :by_date # or :by_position
end

