# == Schema Information
#
# Table name: page_fields
#
#  id       :integer          not null, primary key
#  page_id  :integer          not null
#  name     :string(120)      not null
#  value    :text
#  ftype    :string(60)
#  position :integer          not null
#

module Rhinoart
	class PageField < Rhinoart::Base
		self.inheritance_column = "non_sti"
		after_save :update_page_date
		after_destroy :update_page_date

		belongs_to :page, :inverse_of => :page_field	
		accepts_nested_attributes_for :page

		has_one :attachment, as: :attachable, class_name: "Rhinoart::Files", :autosave => true, :dependent => :destroy
		accepts_nested_attributes_for :attachment, allow_destroy: true #, reject_if: :all_blank

		default_scope { order 'position' }
		acts_as_list scope: :page_id

		FIELD_TYPES = { text: 'Text', textarea: 'Textarea', file: 'File', boolean: 'Bollean', title: 'Title', meta: 'Meta descr and key' }

		validates :name, :ftype, presence: true
		validates_uniqueness_of :name, :scope => :page_id

		validates :ftype, inclusion: { in: FIELD_TYPES.keys.map(&:to_s) }
	
		def select_list
			FIELD_TYPES.map { |ft| [ft[1], ft[0]] }
		end
	end
end
