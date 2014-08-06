module Rhinoart
	class VoteAnswerList < ActiveRecord::Base
		belongs_to :vote_question
		
	end
end