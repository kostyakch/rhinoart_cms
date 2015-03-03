# == Schema Information
#
# Table name: rhinoart_galleries
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  url        :string(150)
#  name       :string(255)      not null
#  descr      :text
#  active     :boolean          default(TRUE)
#  position   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

module Rhinoart
	class Gallery < ActiveRecord::Base
		#3attr_accessible :active, :descr, :name, :url

		has_many :gallery_images, ->{order 'position asc'}, :autosave => true, :dependent => :destroy
		accepts_nested_attributes_for :gallery_images, :allow_destroy => true

		# Validations
		validates :name, :length => { :in => 2..150 }, uniqueness: true


		default_scope { order 'position asc' }
		acts_as_list  :scope => [:page_id]
	end
end
