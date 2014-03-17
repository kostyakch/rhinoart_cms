# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  page_id    :integer
#  url        :string(150)
#  name       :string(255)      not null
#  descr      :text
#  active     :boolean          default(TRUE)
#  position   :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#

module Rhinoart
	class Gallery < ActiveRecord::Base
	  #3attr_accessible :active, :descr, :name, :url

	  has_many :gallery_image, :order => 'position', :autosave => true, :dependent => :destroy
	  accepts_nested_attributes_for :gallery_image, :allow_destroy => true

	  # Validations
	  validates :name, :length => { :in => 2..150 }, uniqueness: true


	end
end
