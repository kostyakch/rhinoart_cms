module Rhinoart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Rhinoart CMS installation'

    def copy_files
      copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"
      copy_file "views/layouts/application.html.haml", "app/views/layouts/application.html.haml"

      copy_file "views/pages/index.html.haml", "app/views/pages/index.html.haml"
      copy_file "views/pages/internal.html.haml", "app/views/pages/internal.html.haml"

      copy_file "helpers/pages_helper.rb", "app/helpers/pages_helper.rb"
    end

    def add_route
      route "match '*url' => 'pages#internal', :as => :page, via: [:get]"
      route "root 'pages#index'"
      route 'mount Rhinoart::Engine, at: "/admin"'
    end

    def create_tables
      rake 'rhinoart:install:migrations'
      rake 'db:migrate'
      rake 'db:populate'
    end
  end
end
