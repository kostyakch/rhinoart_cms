module Rhinoart
  module SessionsHelper

    # def sign_in(user)
    #   cookies.permanent[:remember_token] = user.remember_token
    #   self.current_user = user
    # end

    # def signed_in?
    #   !current_user.nil?
    # end  

    # def current_user=(user)
    #   @current_user = user
    # end

    # def current_user
    #   @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    # end

    # def current_user?(user)
    #   user == current_user
    # end

    # def sign_out
    #   self.current_user = nil
    #   cookies.delete(:remember_token)
    # end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end

    def store_location
      session[:return_to] = request.url
    end

    # def has_role?(role)
    #   res = false
    #   current_user.roles.split(',').each do |r|
    #     res = (r == role)
    #     break if res
    #   end

    #   return res
    # end

    def setting_by_name(name, reload = false)
      if !reload && session[:"setting_#{name}"].present?
        session[:"setting_#{name}"]
      else
        setting = Setting.find_by_name(name)
        session[:"setting_#{name}"] = setting.value if setting.present?
      end
    end  
  end
end
