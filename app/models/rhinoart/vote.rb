module Rhinoart
	class Vote < ActiveRecord::Base
		has_many :vote_questions
		accepts_nested_attributes_for :vote_questions, allow_destroy: true

		has_many :votes_passed_users
	end
end