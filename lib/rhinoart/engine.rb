module Rhinoart
  class Engine < ::Rails::Engine
    isolate_namespace Rhinoart

    require "haml"
    require "foreigner"
    require "acts_as_list"
    require "mini_magick"
    require 'carrierwave'
    require 'russian'
    require 'bootstrap-datepicker-rails'
    require 'will_paginate'
    require "devise"
    require "cancan"    
  end
end
