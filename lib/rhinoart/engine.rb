require 'haml'
require 'acts_as_list'
require 'mini_magick'
require 'carrierwave'
require 'russian'
require 'bootstrap-datepicker-rails'
require 'will_paginate'
require 'cancan'
require 'delayed_job_active_record'
require 'devise'
require 'rolify'
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

    initializer 'rhinoart.extend_action_view' do
      ActiveSupport.on_load :action_view do
        include ViewHelpers::ApplicationHelper
        include ViewHelpers::MenuHelper
        include ViewHelpers::PagesHelper
        include ViewHelpers::SessionHelper
        include ViewHelpers::UsersHelper
      end
    end

  end
end

