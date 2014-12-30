# == Schema Information
#
# Table name: page_comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  page_id    :integer
#  parent_id  :integer
#  comment    :text             not null
#  approved   :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

module Rhinoart
	class PageComment < Rhinoart::Base
		include ActionView::Helpers
		before_validation :clear_html

		belongs_to :page, :inverse_of => :page_comment	
		accepts_nested_attributes_for :page

		belongs_to :user
		accepts_nested_attributes_for :user #, :allow_destroy => true

		# Validations
		validates :comment, presence: true
		validates :comment, length: { minimum: 3, maximum: 1500 }

		after_save :update_page_date
		after_destroy :update_page_date

		def children
			PageComment.where('parent_id = ?', self.id)
		end


		def clear_html
			self.comment = strip_tags self.comment
		end
	end
end