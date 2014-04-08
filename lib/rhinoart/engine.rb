module Rhinoart
  class Engine < ::Rails::Engine
    isolate_namespace Rhinoart

    require "mini_magick"
	require 'carrierwave'
	require 'russian'
	require 'bootstrap-datepicker-rails'
	require 'foreigner'
	require 'acts_as_list'
  end
end
