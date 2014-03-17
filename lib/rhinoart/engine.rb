module Rhinoart
  class Engine < ::Rails::Engine
    isolate_namespace Rhinoart

    require "mini_magick"
	require 'carrierwave'
	require 'russian'
  end
end
