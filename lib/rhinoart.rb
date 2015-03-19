require 'rhinoart/engine'
require 'rhinoart/asset_registration'

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

end

require 'rhinoart/railtie' if defined?(Rails)
