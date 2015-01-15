# == Schema Information
#
# Table name: rhinoart_page_contents
#
#  id       :integer          not null, primary key
#  page_id  :integer
#  name     :string(100)      not null
#  content  :text
#  position :integer          not null
#

module Rhinoart
	class PageContent < Rhinoart::Base
		belongs_to :page, :inverse_of => :page_content	
		accepts_nested_attributes_for :page
		after_save :update_page_date
		after_destroy :update_page_date

		acts_as_list  :scope => :page_id
		default_scope { order 'position asc' }

		has_paper_trail
	end
end

