module Rhinoart
  module ViewHelpers
    module SessionHelper

      def setting_by_name(name, reload = false)
        return session[:"setting_#{name}"] if !reload && session[:"setting_#{name}"].present?
        if setting = Setting.find_by_name(name)
          session[:"setting_#{name}"] = setting.value
        end
      end

      def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
      end

      def store_location
        session[:return_to] = request.url
      end

    end
  end
end
