# == Schema Information
#
# Table name: gallery_images
#
#  id         :integer          not null, primary key
#  gallery_id :integer
#  path       :string(150)
#  annotation :text
#  main       :boolean          default(FALSE), not null
#  active     :boolean          default(TRUE), not null
#  position   :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

module Rhinoart
	class GalleryImage < ActiveRecord::Base
	  #attr_accessible :active, :annotation, :main, :path, :position, :gallery_id, :path_cache, :images_attributes

	  belongs_to :gallery, :inverse_of => :gallery_image
	  acts_as_list scope: :gallery_id

	  default_scope order: ['main DESC', 'position']

	  # Validations
	  validates :gallery_id, presence: true
	  validates :path, presence: true, :uniqueness => { :scope => :gallery_id }

	  #mount_uploader :path, GalleryImageUploader

	end
end