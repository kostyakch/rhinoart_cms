module Rhinoart
	class VoteUserAnswer < ActiveRecord::Base
		# before_save :set_user
		belongs_to :vote_question

		private
			def set_user
				self.user_id = 1 #current_user.id
			end
	end
end