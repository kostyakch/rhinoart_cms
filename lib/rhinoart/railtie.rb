module RhinoartGallery
  class Railtie < Rails::Railtie
    initializer "shr_gallery_railtie.configure_rails_initialization" do |app|
      app.config.assets.precompile += %w( jquery.tablesorter.js )
    end
  end
end