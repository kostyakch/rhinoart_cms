# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(250)
#  email           :string(100)      not null
#  active          :boolean          default(TRUE), not null
#  roles           :string(255)      default("ROLE_USER"), not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

module Rhinoart
  class User < ActiveRecord::Base
    has_secure_password

    before_save { |user| user.email = email.downcase }
    before_save :create_remember_token

    validates :name,  length: { :in => 3..50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

    validates :password, confirmation: true, length: { :in => 3..50 }#, :on => :create
    validates :password_confirmation, presence: true#, :on => :create

    def name_email
      "#{self.name } (#{self.email})"    
    end

    def has_role?(role)
      res = false
      self.roles.split(',').each do |r|
        res = (r == role)
        break if res
      end

      return res
    end

    private

      def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64 if !self.remember_token.present?
      end

  end
end
