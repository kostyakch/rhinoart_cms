module Rhinoart
  module ViewHelpers
    module ApplicationHelper

      def top_menu_items(parent = nil)
        if parent.blank?
          Page.where("active = true AND menu = true AND parent_id IS NULL").order(:position, :name)
        else
          Page.where("active = true AND menu = true AND parent_id = #{parent.id}").order(:position, :name) if parent.ptype == 'page'
        end
      end

      def meta_tags(page)
        require "rhinoart/version"
        begin
          res = "<meta name=\"generator\" content=\"RhinoArtCMS #{Rhinoart::VERSION}\">\n"
          if page and page.page_field
            page.page_field.where("ftype = 'meta' and ftype is not null").each do |meta|
              res += "<meta name=\"#{meta.name}\" content=\"#{meta.value}\" />\n"
            end
          end
        rescue
        end

        raw res
      end

      def render_partial_if_exists(partial)
        render partial: partial
      end

      def sys_version
        require "rhinoart/version"
        Rhinoart::VERSION
      end

      def available_locales
        if current_user.present? && current_user.locales.present? && current_user.locales.count > 0
          current_user.locales
        else
          I18n.available_locales
        end
      end

      def append_javascript(path)
        @javascripts ||= []
        @javascripts << path
        nil
      end

      def append_stylesheet(path)
        @stylesheets ||= []
        @stylesheets << path
        nil
      end

      def appended_javascripts
        (@javascripts || []).map do |js|
          javascript_include_tag(js)
        end.join("\n").html_safe
      end

      def appended_stylesheets
        (@stylesheets || []).map do |css|
          stylesheet_link_tag css, :media => "all"
        end.join("\n").html_safe
      end
    end
	end
end
