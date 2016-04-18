# == Schema Information
#
# Table name: rhinoart_settings
#
#  id    :integer          not null, primary key
#  name  :string(120)      default(""), not null
#  value :text
#  descr :text
#

module Rhinoart
	class Setting < ActiveRecord::Base
		before_save :name_downcase

		#attr_accessible :name, :value, :descr

		default_scope { order 'name' }

		validates :name, uniqueness: { case_sensitive: false }, 
			:format => { :with => /\A[-_a-zA-Z0-9]+\z/ }
		validates :name, :length => { :in => 2..150 }
		# validates :value
		has_paper_trail
		

		private

			def name_downcase
				self.name = self.name.downcase
			end

			def self.get(name, default = nil)
				find_by_name(name).try(:value) || default
			end

	end
end

# HOWTO: Make settings through cache
# class Setting
#   include Singleton

#   def get(name, default_value = nil)
#     Rhinoart::Setting.find_by_name(name).try(:value) || default_value
#   end

#   def as_cache_key
#     'setting'
#   end

#   def self.get(name, default_value = nil)
#     instance.get(name, default_value)
#   end

#   cache_method :get, 1.day

# end