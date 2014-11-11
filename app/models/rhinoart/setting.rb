# == Schema Information
#
# Table name: settings
#
#  id    :integer          not null, primary key
#  name  :string(120)      default(""), not null
#  value :string(255)      default(""), not null
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
		
		private

			def name_downcase
				self.name = self.name.downcase
			end
	end
end