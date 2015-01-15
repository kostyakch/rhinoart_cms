# == Schema Information
#
# Table name: rhinoart_users
#
#  id                     :integer          not null, primary key
#  name                   :string(250)
#  email                  :string(100)      not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  admin_role             :string(255)
#  frontend_role          :string(255)
#  approved               :boolean          default(FALSE), not null
#  info                   :text
#

module Rhinoart
  class User < ActiveRecord::Base
    belongs_to :userable, polymorphic: true #iln 24.07.14

    # Include default devise modules. Others available are:
    devise :database_authenticatable, :recoverable, :registerable, :trackable, :validatable
    
    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token
    before_save :join_admin_roles
    after_initialize :split_admin_role
    after_create :notify_about_new_user
    after_update :notify_after_change_approved


    SAFE_INFO_ACCESSORS = [:locales]
    store :info, accessors: SAFE_INFO_ACCESSORS, coder: JSON

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, allow_blank: true

    # validates :password, confirmation: true, length: { :in => 3..50 }#, :on => :create
    # validates :password_confirmation, presence: true#, :on => :create

    ADMIN_PANEL_ROLE_SUPER_USER = "Super User"
    ADMIN_PANEL_ROLE_USERS_MANAGER = "Users Manager"
    ADMIN_PANEL_ROLE_CONTENT_MANAGER = "Content Manager"
    ADMIN_PANEL_ROLES = [ADMIN_PANEL_ROLE_USERS_MANAGER, ADMIN_PANEL_ROLE_CONTENT_MANAGER, ADMIN_PANEL_ROLE_SUPER_USER]

    FRONTEND_ROLES = RhinoartConfig.config.frontend_roles


    def self.current
        Thread.current[:user]
    end

    def self.current=(user)
        Thread.current[:user] = user
    end
    
    def name_email
      "#{self.name } (#{self.email})"    
    end


    def has_access_to_admin_panel?
        res = false
        begin
            ADMIN_PANEL_ROLES.each do |role|
                #db_roles = admin_role.split(',')
                return (admin_role.include? role) if (admin_role.include? role) == true
            end
        rescue
            return false
        end
        return res
    end
    alias_method :admin?, :has_access_to_admin_panel?

    def has_admin_role?(role)
        admin_role.include? role.to_s if admin_role.present?    
    end  

    def has_access_to_frontend?
        res = false
        begin
            FRONTEND_ROLES.each do |role|
                return (frontend_role.include? role) if (frontend_role.include? role) == true
            end
        rescue
            return false
        end
        return res
    end
    alias_method :frontend_user?, :has_access_to_frontend?

    def has_frontend_role?(role)
        frontend_role.include? role.to_s if frontend_role.present?    
    end  

    def self.user_manager_emails  
        where("#{quoted_table_name}.admin_role LIKE ?", "%#{ADMIN_PANEL_ROLE_USERS_MANAGER}%").pluck(:email) #.join(',') #map(&:inspect)
    end

    def active_for_authentication? 
        super && approved? 
    end 

    def inactive_message 
        if !approved? 
            :not_approved 
        else 
            super # Use whatever other message 
        end 
    end

    def ability
        @ability ||= Ability.new(self)
    end
    delegate :can?, :cannot?, :to => :ability
    
    private

        def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64 if !self.remember_token.present?
        end

        def join_admin_roles
            if self.admin_role.kind_of?(Array)
                self.admin_role.reject! { |ar| ar.empty? }
                self.admin_role = self.admin_role.join(',')
            end
        end

        def split_admin_role
            self.admin_role = self.admin_role.split(',') if self.admin_role.present?
        end

        def notify_about_new_user        
            User.user_manager_emails.each do |mail_to|
                NotificationsMailer.delay.new_user_notification(self, mail_to)
            end
            NotificationsMailer.delay.new_user_welcome(self)
        end

        def notify_after_change_approved   
            NotificationsMailer.delay.user_grant_access_notification(self) if (self.approved_changed? && self.approved == true)
        end 
        
        def set_default_frontend_role
            self.frontend_role = FRONTEND_ROLES.first if !self.frontend_role.present?
        end
  end
end
