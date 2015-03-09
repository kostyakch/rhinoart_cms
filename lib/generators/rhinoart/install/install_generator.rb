module Rhinoart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Rhinoart CMS installation'

    def copy_files
      copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"
      copy_file "views/layouts/pages.html.haml", "app/views/layouts/pages.html.haml"
    end

    def add_route
      route "match '*url' => 'pages#internal', :as => :page, via: [:get]"
      route "root 'pages#index'"
      route 'mount Rhinoart::Engine, at: "/admin"'
    end

    def create_tables
      rake 'rhinoart:install:migrations'
      rake 'db:migrate'
    end
  end
end
