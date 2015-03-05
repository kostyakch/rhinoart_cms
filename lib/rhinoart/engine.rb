require 'haml'
require 'foreigner'
require 'acts_as_list'
require 'mini_magick'
require 'carrierwave'
require 'russian'
require 'bootstrap-datepicker-rails'
require 'will_paginate'
# require "devise"
require 'cancan'

require 'delayed_job_active_record'
require 'devise'
require 'globalize'
require 'globalize-accessors'
require 'globalize-versioning'
require 'paper_trail'

module Rhinoart
  class Engine < ::Rails::Engine
    isolate_namespace Rhinoart

    config.to_prepare do
      Devise::SessionsController.layout "application"
    end

  end
end

