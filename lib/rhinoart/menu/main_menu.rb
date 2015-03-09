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
        icon: 'fa-icon-comments',
        link: proc{ rhinoart.page_comments_path },
        label: :_COMMENTS,
        allowed: proc{ can?(:manage, :content) and Rails.configuration.try(:show_comments) },
        active: proc{ controller_name == 'page_comments' }
      })

      # add_item({
      #   icon: 'fa-icon-list-alt',
      #   link: rhinoart.votes_path,
      #   label: :_VOTES,
      #   allowed: ->{ can?(:manage, :all) && Rails.configuration.try(:show_vote) },
      #   active: ->{ controller_name == 'votes' }
      # })

      add_item({
        icon: 'fa-icon-book',
        link: proc{ rhinobook.books_path },
        label: :_BOOKS,
        allowed: proc{ can?(:manage, :books) },
        active: proc{ controller_name == 'books' || controller_name == 'chapters' || controller.class.name == 'Rhinobook::PagesController' }
      }) if defined?(Rhinobook)

      add_item({
        icon: 'fa-icon-shopping-cart',
        link: proc{ rhinocatalog.root_path },
        label: :_CATALOG,
        allowed: proc{ can?(:manage, :catalog) },
        active: proc{ controller.class.name == 'Rhinocatalog::CategoriesController' || controller.class.name == 'Rhinocatalog::ProductsController' }
      }) if defined?(Rhinocatalog)

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