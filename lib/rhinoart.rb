require 'devise'
require "rhinoart/engine"
require 'globalize'
require 'globalize-accessors'
require 'globalize-versioning'
require 'paper_trail'

module Rhinoart
	class Engine < ::Rails::Engine
		config.to_prepare do
			Devise::SessionsController.layout "application"
		end
	end	
end
