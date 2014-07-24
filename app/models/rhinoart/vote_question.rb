class VoteQuestion < ActiveRecord::Base
	has_many :vote_answer_lists
	has_many :vote_user_answers
end
