module Rhinoart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Rhinoart CMS installation'

    def copy_files
      copy_file "controllers/application_controller.rb", "app/controllers/application_controller.rb"
      copy_file "controllers/pages_controller.rb", "app/controllers/pages_controller.rb"

      copy_file "views/layouts/application.html.haml", "app/views/layouts/application.html.haml"
      copy_file "views/pages/index.html.haml", "app/views/pages/index.html.haml"
      copy_file "views/pages/internal.html.haml", "app/views/pages/internal.html.haml"
      copy_file "views/shared/not_found.html.haml", "app/views/shared/not_found.html.haml"

      copy_file "helpers/application_helper.rb", "app/helpers/application_helper.rb"
      copy_file "helpers/pages_helper.rb", "app/helpers/pages_helper.rb"
      copy_file "helpers/settings_helper.rb", "app/helpers/settings_helper.rb"

      copy_file "files/help.pdf", "public/help.pdf"
      copy_file "initializers/rhinoart.rb", "config/initializers/rhinoart.rb"
    end

    def add_route
      route "match '*url' => 'pages#internal', :as => :page, via: [:get]"
      route "root 'pages#index'"
      route 'mount Rhinoart::Engine, at: "/"'
    end

    def create_tables
      rake 'rhinoart:install:migrations'
      rake 'db:create'
      rake 'db:migrate'
      rake 'db:populate'
    end

    def create_config
      inject_into_file 'config/application.rb', before: /end$/ do
        "\n  # Replace of yours\n"
        "\n  config.help_file_path = \"#{Rails.public_path}/help.pdf\"\n"
      end          
      inject_into_file 'config/environments/development.rb', before: /end$/ do
        "\n  config.redirect_to_www = false\n"
      end          
      inject_into_file 'config/environments/production.rb', before: /end$/ do
        "\n  config.redirect_to_www = true\n"
      end          
    end
  end
end
