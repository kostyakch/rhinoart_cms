require_dependency "rhinoart/application_controller"

module Rhinoart
	class StructuresController < PagesController
		before_action { authorize! :manage, :all }
	end
end
