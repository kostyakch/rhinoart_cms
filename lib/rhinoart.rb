require 'devise'
require "rhinoart/engine"


module Rhinoart
	class Engine < ::Rails::Engine
		config.to_prepare do
			Devise::SessionsController.layout "application"
		end
	end	
end
