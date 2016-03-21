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
		include UserRoles
		include ApplicationHelper
		rolify

		belongs_to :userable, polymorphic: true #iln 24.07.14

		# Include default devise modules. Others available are:
		# devise :database_authenticatable, :recoverable, :registerable, :trackable, :validatable #, :omniauthable, :omniauth_providers => [:google_oauth2]
		devise *Rhinoart.devise_scopes

		before_save { |user| user.email = email.downcase }
		before_save :create_remember_token
		after_create :notify_about_new_user, :set_default_frontend_role
		after_update :notify_after_change_approved

		SAFE_INFO_ACCESSORS = [:locales, :token]
		store :info, accessors: SAFE_INFO_ACCESSORS, coder: JSON

		# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		# validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, allow_blank: true

		# validates :password, confirmation: true, length: { :in => 3..50 }#, :on => :create
		# validates :password_confirmation, presence: true#, :on => :create

		add_admin_role 'Super User'
		add_admin_role 'Users Manager'
		add_admin_role 'Content Manager'

		mount_uploader :avatar, ImageUploader

		FRONTEND_ROLES = RhinoartConfig.config.frontend_roles
		if (Rails.configuration.paper_trail_ignore rescue nil).present?
			has_paper_trail ignore: Rails.configuration.paper_trail_ignore
		else
			has_paper_trail ignore: [:api_token, :updated_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip]
		end

		def self.current
			Thread.current[:user]
		end

		def self.current=(user)
			Thread.current[:user] = user
		end

		def name_email
			"#{self.name } (#{self.email})"
		end

		def locales=(value)
			value.reject! { |l| l.empty? }
			super
		end

		def has_access_to_admin_panel?
			roles.map(&:name).each do |rol|
				unless !ADMIN_PANEL_ROLES.include? rol					
					return true					
				end				
			end
			false
		end
		alias_method :admin?, :has_access_to_admin_panel?

		def has_admin_role?(role)
			roles.map(&:name).include? role
		end

		def self.admin_users
			joins(:rhinoart_users_roles, :roles).where(approved: true, roles: {name: ADMIN_PANEL_ROLES}).group('rhinoart_users.id')
		end

		def has_access_to_frontend?
			FRONTEND_ROLES.any?{ |role| roles.map(&:name).include?(role.to_s) }
		end
		alias_method :frontend_user?, :has_access_to_frontend?
		alias_method :has_frontend_role?, :has_role?

		def self.user_manager_emails
			with_role(ADMIN_PANEL_ROLE_USERS_MANAGER).pluck(:email)
		end

		def active_for_authentication?
			super && approved?
		end

		def inactive_message
			return :not_approved if !approved?
			super # Use whatever other message
		end

		def ability
			@ability ||= Ability.new(self)
		end
		delegate :can?, :cannot?, :to => :ability

		def clear_roles(roles)
			roles.each do |r|
				relf.remove_role(r) rescue nil
			end
		end

		def self.from_omniauth(access_token)
			data = access_token.info
			user = find_by(:email => data["email"])

			if user.present?
				user.password = Devise.friendly_token[0,20]
				user.token = access_token['credentials']['token']
			else
				user = create(
					name: data["name"],
					email: data["email"],
					password: Devise.friendly_token[0,20],
					token: access_token['credentials']['token'],
					approved: true
				)
			end

			user
		end

		private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64 if !self.remember_token.present?
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
			self.add_role FRONTEND_ROLES.first
		end

		def set_user_name
			if name_changed?
				self.first_name = self.name.split(' ').first
				self.last_name = self.name.split(' ').last if self.first_name != self.name.split(' ').last
			elsif first_name.present? && last_name.present?
				self.name = "#{first_name} #{last_name}"
			end
		end
  end
end
