module Rhinoart
  module Menu
    class ContentMenu < Rhinoart::Menu::Base

      def item_class
        @item_class ||= Class.new(Rhinoart::Menu::Item) do
          attr_accessor :notification
        end
      end

      add_item({
          icon: 'fa-icon-tasks',
          link: proc{ rhinoart.new_page_path },
          label: :_NEWS_ARTICLES,
          notification: ->{ Rhinoart::Page.count }
        })

      add_item({
          icon: 'fa-icon-book',
          link: proc{ rhinoart.new_page_path },
          label: :_BLOGS,
          notification: ->{ Rhinoart::Page.where("ptype='blog'").count }
        })

      add_item({
          icon: 'fa-icon-comments-alt',
          link: proc{ rhinoart.page_comments_path },
          label: :_COMMENTS,
          notification: ->{ Rhinoart::PageComment.count }
        })

      add_item({
          icon: 'fa-icon-group',
          link: proc{ rhinoart.users_path },
          label: :_USERS,
          notification: ->{ Rhinoart::User.count }
        })

      add_item({
          icon: 'fa-icon-cogs',
          link: proc{ rhinoart.settings_path },
          label: :_SETTINGS,
          notification: ->{ Rhinoart::Setting.count }
      })

    end
  end
end