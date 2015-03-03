module Rhinoart
  class InstallGenerator < Rails::Generators::Base

    desc 'Rhinoart CMS installation'

    def add_route
      route 'mount Rhinoart::Engine, at: "/admin"'
    end

    def create_db
      rake 'db:create'
      rake 'rhinoart:install:migrations'
      rake 'db:migrate'
    end
  end
end
