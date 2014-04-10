module Rhinoart
  class Engine < ::Rails::Engine
    isolate_namespace Rhinoart

    require "foreigner"
    require "acts_as_list"
    require "mini_magick"
    require 'carrierwave'
    require 'russian'
    require 'bootstrap-datepicker-rails'
    require 'globalize'
    require 'will_paginate'
  end
end
