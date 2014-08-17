module Rhinoart
	class VoteQuestion < ActiveRecord::Base
		has_many :vote_answer_lists
		# has_many :vote_user_answers		

		belongs_to :vote
	end
end