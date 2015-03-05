require 'rhinoart/engine'

module Rhinoart
  extend ActiveSupport::Autoload

  eager_autoload do
    autoload :Menu
  end

end

require 'rhinoart/railtie' if defined?(Rails)
