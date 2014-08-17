module Rhinoart
	class VoteUserAnswer < ActiveRecord::Base
		belongs_to :vote_answer_list
		belongs_to :votes_passed_user

	end
end