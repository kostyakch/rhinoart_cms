module Rhinoart
  module UserRoles
    extend ActiveSupport::Concern

    included do
      ADMIN_PANEL_ROLES = []
    end

    module ClassMethods

      def add_admin_role(role_name)
        role_const_name = "ADMIN_PANEL_ROLE_#{role_name.gsub(/\s+/, '').underscore.upcase}"
        return if const_defined?(role_const_name) #or raise?
        const_set role_const_name, role_name
        ADMIN_PANEL_ROLES.push(role_name)
      end

    end

  end
end