module Rhinoart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Rhinoart CMS installation'

    def copy_files
      copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"
      copy_file "views/layouts/pages.html.haml", "app/views/layouts/pages.html.haml"
    end

    def add_route
      route 'mount Rhinoart::Engine, at: "/admin"'
      route "root 'pages#index'"
      route "match '*url' => 'pages#internal', :as => :page, via: [:get]"
    end

    def create_db
      rake 'db:create'
      rake 'rhinoart:install:migrations'
      rake 'db:migrate'
    end
  end
end
