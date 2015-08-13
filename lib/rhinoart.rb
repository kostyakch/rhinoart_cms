require 'rhinoart/engine'
require 'rhinoart/asset_registration'
require 'rhinoart/work_links'

module Rhinoart
  extend ActiveSupport::Autoload
  extend AssetRegistration

  eager_autoload do
    autoload :Menu
    autoload :ViewHelpers
  end

  def self.setting(name, value = nil)
    mattr_accessor name.to_sym
    self.send("#{name}=", value)
  end

  def self.setup
    yield self
  end

  setting('device_namespace', :users)

  setting('devise_controllers', {
    sessions: 'rhinoart/sessions',
    passwords: 'rhinoart/passwords',
    omniauth_callbacks: 'rhinoart/omniauth_callbacks'
  })

  setting('devise_routes', {
    class_name: 'Rhinoart::User',
    module: :devise,
    controllers: Rhinoart.devise_controllers
  })

end

require 'rhinoart/railtie' if defined?(Rails)
