module Rhinoart
  class Railtie < Rails::Railtie

    VIEW_HELPERS_PATH = 'lib/rhinoart/view_helpers/'

    initializer "rhinoart_railtie.add_precompile_assets" do |app|
      app.config.assets.precompile += %w( jquery.tablesorter.js )
    end

  end
end