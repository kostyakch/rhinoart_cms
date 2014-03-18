require_dependency "rhinoart/application_controller"

module Rhinoart
	class StructuresController < PagesController
		before_filter { access_only_roles %w[ROLE_ADMIN] }
	end
end
