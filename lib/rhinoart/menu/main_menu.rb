module Rhinoart
  module Menu
    class MainMenu < Rhinoart::Menu::Base

      add_item({
        icon: 'fa-icon-home',
        link: proc{ rhinoart.root_path },
        label: :_DASHBOARD,
        allowed: true,
        active: proc{ controller.class.name == 'Rhinoart::DashboardController' }
      })

      add_item({
        icon: 'fa-icon-tasks',
        link: proc{ rhinoart.pages_path },
        label: :_CONTENT,
        allowed: proc{ can?(:manage, :content) },
        active: proc{ controller.class.name == 'Rhinoart::PagesController' }
      })

      add_item({
        icon: 'fa-icon-sitemap',
        link: proc{ rhinoart.structures_path },
        label: :_SITE_STRUCTURE,
        allowed: proc{ can?(:manage, :all) },
        active: proc{ controller_name == 'structures' }
      })

      add_item({
        icon: 'fa-icon-group',
        link: proc{ rhinoart.users_path },
        label: :_USERS,
        allowed: proc{ can?(:manage, :users) },
        active: proc{ controller_name == 'users' }
      })

      add_item({
        icon: 'fa-icon-cogs',
        link: proc{ rhinoart.settings_path },
        label: :_SETTINGS,
        allowed: proc{ can?(:manage, :settings) },
        active: proc{ controller_name == 'settings' }
      })

    end
  end
end